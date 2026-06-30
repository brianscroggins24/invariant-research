# frozen_string_literal: true

require 'digest'
require 'date'
require 'open3'
require 'pathname'
require 'yaml'

module IngestionValidation
  module_function

  ALLOWED_SOURCE_STATUSES = %w[active superseded pending-ingestion review-required reviewed disputed stale archived].freeze
  ALLOWED_PAGE_STATUSES = %w[draft proposed review-required reviewed disputed stale superseded archived].freeze
  ALLOWED_CLAIM_STATUSES = %w[review-required reviewed disputed stale superseded archived].freeze
  SOURCE_SUMMARY_PREFIX = 'SOURCE-SUMMARY-'.freeze
  GOVERNED_MARKDOWN_ROOTS = %w[AGENTS.md README.md index.md log.md].freeze
  GOVERNED_MARKDOWN_DIRS = %w[wiki].freeze
  ROOT_RELATIVE_PREFIXES = %w[wiki raw templates index.md log.md AGENTS.md README.md].freeze

  def repo_root(from = __dir__)
    File.expand_path('../../../../', from)
  end

  def load_yaml(path)
    YAML.load_file(path)
  rescue StandardError => e
    raise StandardError, "malformed YAML in #{path}: #{e.message}"
  end

  def read_text(path)
    File.binread(path).force_encoding('UTF-8')
  end

  def parse_front_matter(text, path)
    match = text.match(/\A---\n(.*?)\n---\n/m)
    raise StandardError, "missing YAML front matter in #{path}" unless match

    front_matter = YAML.load(match[1])
    body = text.match(/\A---\n.*?\n---\n/m).post_match
    [front_matter, body]
  rescue StandardError => e
    raise StandardError, "malformed front matter in #{path}: #{e.message}"
  end

  def read_front_matter(path)
    parse_front_matter(read_text(path), path)
  end

  def read_capture_report(path)
    report_path = File.expand_path(path)
    text = File.binread(report_path).force_encoding('UTF-8')
    front_matter, = parse_front_matter(text, report_path)
    [front_matter, report_path]
  end

  def git_blob_exists?(root, ref, rel_path)
    spec = ref == :index ? ":#{rel_path}" : "#{ref}:#{rel_path}"
    system('git', '-C', root, 'cat-file', '-e', spec)
  end

  def git_blob_text(root, ref, rel_path)
    return nil unless git_blob_exists?(root, ref, rel_path)

    spec = ref == :index ? ":#{rel_path}" : "#{ref}:#{rel_path}"
    stdout, stderr, status = Open3.capture3('git', '-C', root, 'show', spec)
    return stdout.force_encoding('UTF-8') if status.success?

    raise StandardError, "unable to read #{spec}: #{stderr.strip}"
  end

  def file_exists?(root, path)
    candidate = Pathname.new(path)
    candidate = Pathname.new(root).join(candidate) unless candidate.absolute?
    candidate.exist?
  end

  def strip_fragment(target)
    target.to_s.split('#', 2).first
  end

  def root_relative_target?(target)
    ROOT_RELATIVE_PREFIXES.any? do |prefix|
      target == prefix || target.start_with?("#{prefix}/")
    end
  end

  def resolve_link_target(source_path, raw_target, root)
    target = strip_fragment(raw_target)
    return nil if target.empty?
    return nil if target.match?(/\A(?:https?:|mailto:)/i)
    return nil if target.start_with?('#')

    source_dir = Pathname.new(source_path).dirname
    root_path = Pathname.new(root)
    candidates = []

    # Root-relative links are only supported from repository-root documents.
    if source_dir == root_path
      candidates << root_path.join(target)
      candidates << root_path.join("#{target}.md") unless target.end_with?('.md')
    end

    candidates << source_dir.join(target)
    candidates << source_dir.join("#{target}.md") unless target.end_with?('.md')

    if target.start_with?('/')
      stripped = target.sub(%r{\A/+}, '')
      candidates << root_path.join(stripped)
      candidates << root_path.join("#{stripped}.md") unless stripped.end_with?('.md')
    elsif root_relative_target?(target) && source_dir == root_path
      candidates << root_path.join(target)
      candidates << root_path.join("#{target}.md") unless target.end_with?('.md')
    end

    candidates.uniq.find { |candidate| candidate.exist? }
  end

  def capture_report_errors(report, base_dir: Dir.pwd)
    report = report.transform_keys(&:to_s)
    errors = []

    required = %w[artifact_path artifact_exists artifact_complete artifact_inspectable capture_method canonical_url capture_date failure_reason]
    required.each do |field|
      errors << "capture report missing #{field}" unless report.key?(field)
    end
    return errors unless errors.empty?

    artifact_path = report['artifact_path'].to_s.strip
    artifact_path_obj = Pathname.new(artifact_path)
    artifact_path_obj = Pathname.new(base_dir).join(artifact_path_obj) unless artifact_path_obj.absolute?

    artifact_exists = report['artifact_exists'] == true
    artifact_complete = report['artifact_complete'] == true
    artifact_inspectable = report['artifact_inspectable'] == true
    failure_reason = report['failure_reason'].to_s.strip

    errors << 'capture report requires artifact_path' if artifact_path.empty?
    errors << "capture report artifact_path does not exist: #{report['artifact_path']}" unless artifact_path_obj.exist?
    errors << 'capture report artifact_exists must be true' unless artifact_exists
    errors << 'capture report artifact_complete must be true' unless artifact_complete
    errors << 'capture report artifact_inspectable must be true' unless artifact_inspectable
    errors << 'capture report failure_reason must be empty for a passing capture' unless failure_reason.empty?
    errors
  end

  def validate_capture_report_path(path, base_dir: Dir.pwd)
    report, report_path = read_capture_report(path)
    errors = capture_report_errors(report, base_dir: base_dir)
    [errors, report_path]
  rescue StandardError => e
    [[e.message], File.expand_path(path)]
  end

  def resolve_source_summaries(sources, pages, root:)
    source_by_id = sources.to_h { |row| [row['source_id'], row] }
    page_summaries = []
    errors = []

    pages.select { |page| page['page_type'] == 'source-summary' }.each do |page|
      path = page['path'].to_s
      if path.strip.empty?
        errors << "source-summary #{page['page_id']} is missing path"
        next
      end

      full_path = Pathname.new(root).join(path)
      unless full_path.exist?
        errors << "source-summary #{page['page_id']} missing summary file: #{path}"
        next
      end

      front_matter, = read_front_matter(full_path)
      source_id = front_matter['source_id'].to_s.strip
      if source_id.empty?
        errors << "source-summary #{page['page_id']} missing source_id in frontmatter"
        next
      end

      if page.key?('source_id') && !page['source_id'].to_s.strip.empty? && page['source_id'] != source_id
        errors << "source-summary #{page['page_id']} registry source_id #{page['source_id']} does not match frontmatter source_id #{source_id}"
      end

      source = source_by_id[source_id]
      unless source
        errors << "source-summary #{page['page_id']} references missing source #{source_id}"
        next
      end

      page_summaries << {
        page_id: page['page_id'],
        page_path: path,
        registry_status: page['status'],
        frontmatter_status: front_matter['status'],
        source_id: source_id
      }
    rescue StandardError => e
      errors << "source-summary #{page['page_id']} malformed frontmatter: #{e.message}"
    end

    [page_summaries, errors]
  end

  def explicit_versions_from_text(text)
    text = text.to_s
    matches = []
    matches.concat(text.scan(/arXiv v(\d+)/i).flatten)
    matches.concat(text.scan(/\bversion\s*[:=]?\s*(\d+)\b/i).flatten)
    matches.concat(text.scan(/\bv(\d+)\b/i).flatten)
    matches.map(&:to_i).uniq
  end

  def explicit_version_from_url(url)
    return nil if url.nil? || url.to_s.empty?

    match = url.to_s.match(/v(\d+)(?:\.pdf)?(?:\z|[?#])/i)
    match && match[1].to_i
  end

  def version_conflicts_for_source(source, source_by_id:)
    errors = []
    source_id = source['source_id']
    version = source['version']
    notes = source['notes'].to_s
    url = source['original_location'].to_s

    if !version.nil?
      unless version.is_a?(Integer) && version.positive?
        errors << "source #{source_id} version must be a positive integer, got #{version.inspect}"
      end
    end

    note_versions = explicit_versions_from_text(notes)
    if note_versions.length > 1
      errors << "source #{source_id} notes contain conflicting version markers: #{note_versions.join(', ')}"
    elsif note_versions.length == 1
      if version.nil?
        errors << "source #{source_id} notes specify version #{note_versions.first} but registry version is missing"
      elsif note_versions.first != version
        errors << "source #{source_id} registry version #{version} conflicts with notes version #{note_versions.first} in notes"
      end
    end

    url_version = explicit_version_from_url(url)
    if url_version
      if version.nil?
        errors << "source #{source_id} original_location specifies version #{url_version} but registry version is missing"
      elsif version != url_version
        errors << "source #{source_id} registry version #{version} conflicts with URL version #{url_version} in original_location"
      end
    end

    Array(source['supersedes']).each do |superseded_id|
      next if superseded_id.to_s.strip.empty?
      errors << "source #{source_id} supersedes missing source #{superseded_id}" unless source_by_id.key?(superseded_id)
    end

    Array(source['superseded_by']).each do |replacement_id|
      next if replacement_id.to_s.strip.empty?
      errors << "source #{source_id} superseded_by missing source #{replacement_id}" unless source_by_id.key?(replacement_id)
    end
    errors
  end

  def source_date_errors(source)
    errors = []
    source_id = source['source_id']
    type = source['source_type'].to_s
    publication_date = source['publication_date']
    retrieved_at = source['retrieved_at']
    notes = source['notes'].to_s
    no_page_level_date = notes.match?(/no page-level (?:publication|last-)?updated date was present/i) ||
                         notes.match?(/did not expose page-level publication dates or last-updated dates/i)

    [publication_date, retrieved_at].compact.each do |date_value|
      next if date_value.to_s.strip.empty?
      begin
        Date.iso8601(date_value.to_s)
      rescue ArgumentError
        errors << "source #{source_id} has invalid date value #{date_value.inspect}"
      end
    end

    if type == 'official-documentation'
      errors << "source #{source_id} official documentation must record retrieved_at" if retrieved_at.nil? || retrieved_at.to_s.strip.empty?
      if no_page_level_date && !publication_date.to_s.strip.empty?
        errors << "source #{source_id} publication_date must be empty when notes say no page-level update date was present"
      end
      if no_page_level_date && publication_date.to_s.strip != '' && retrieved_at.to_s.strip != '' && publication_date == retrieved_at
        errors << "source #{source_id} appears to copy retrieved_at into publication_date despite notes saying no page-level update date was present"
      end
    else
      if publication_date && publication_date.to_s.strip.empty?
        errors << "source #{source_id} publication_date cannot be blank when present"
      end
    end

    errors
  end

  def source_dependency_errors(sources, pages, claims, root: repo_root)
    errors = []
    source_by_id = sources.to_h { |row| [row['source_id'], row] }
    page_by_id = pages.to_h { |row| [row['page_id'], row] }
    summary_pages, summary_errors = resolve_source_summaries(sources, pages, root: root)
    errors.concat(summary_errors)

    sources.each do |source|
      next unless source['status'] == 'active'
      matching = summary_pages.select { |page| page[:source_id] == source['source_id'] }

      if matching.empty?
        errors << "active source #{source['source_id']} has no reviewed source summary"
      elsif matching.length > 1
        errors << "active source #{source['source_id']} has multiple reviewed source summaries: #{matching.map { |page| page[:page_id] }.join(', ')}"
      else
        summary = matching.first
        unless summary[:registry_status] == 'reviewed' && summary[:frontmatter_status] == 'reviewed'
          errors << "active source #{source['source_id']} must have a reviewed source summary"
        end
      end
    end

    summary_pages.each do |summary|
      source = source_by_id[summary[:source_id]]
      next unless source
      next unless summary[:registry_status] == 'reviewed' || summary[:frontmatter_status] == 'reviewed'

      if source['status'] != 'active'
        errors << "reviewed source summary #{summary[:page_id]} references non-active source #{summary[:source_id]}"
      end
      unless summary[:registry_status] == 'reviewed' && summary[:frontmatter_status] == 'reviewed'
        errors << "source-summary #{summary[:page_id]} must be reviewed"
      end
    end

    claims.each do |claim|
      next unless claim['status'] == 'reviewed'

      (claim['sources'] || []).each do |source_ref|
        source_id = source_ref['source_id']
        source = source_by_id[source_id]
        unless source
          errors << "reviewed claim #{claim['claim_id']} references missing source #{source_id}"
          next
        end
        if source['status'] != 'active'
          errors << "reviewed claim #{claim['claim_id']} references non-active source #{source_id}"
        end
        if source_ref['locator'].to_s.strip.empty?
          errors << "reviewed claim #{claim['claim_id']} missing locator for source #{source_id}"
        end
      end

      (claim['related_pages'] || []).each do |page_id|
        errors << "reviewed claim #{claim['claim_id']} references missing related page #{page_id}" unless page_by_id.key?(page_id)
      end
    end

    pages.each do |page|
      next unless page['status'] == 'reviewed'
      next unless %w[source-summary concept theory strategy platform].include?(page['page_type'])

      path = page['path']
      next unless path && !path.empty?
      full_path = Pathname.new(root).join(path)
      next unless full_path.exist?

      front_matter, body = read_front_matter(full_path)
      source_ids = Array(front_matter['sources'])
      source_ids.each do |source_id|
        source = source_by_id[source_id]
        unless source
          errors << "page #{page['page_id']} cites missing source #{source_id}"
          next
        end
        if source['status'] != 'active'
          errors << "page #{page['page_id']} cites non-active source #{source_id}"
        end
      end

      body.scan(/\[CLM-(\d{4})\]/).flatten.each do |claim_suffix|
        claim_id = "CLM-#{claim_suffix}"
        claim = claims.find { |row| row['claim_id'] == claim_id }
        unless claim
          errors << "page #{page['page_id']} cites missing claim #{claim_id}"
          next
        end
        if claim['status'] != 'reviewed'
          errors << "page #{page['page_id']} cites unreviewed claim #{claim_id}"
        end
      end
    end

    errors
  end

  def validate_markdown_links(paths, root:)
    errors = []
    paths.each do |rel_path|
      full_path = Pathname.new(root).join(rel_path)
      next unless full_path.exist?

      text = read_text(full_path)
      in_fence = false

      text.each_line.with_index(1) do |line, line_number|
        if line.match?(/\A\s*(```|~~~)/)
          in_fence = !in_fence
          next
        end
        next if in_fence

        line.scan(/\[[^\]]+\]\(([^)]+)\)/).flatten.each do |raw_target|
          target = strip_fragment(raw_target)
          next if target.empty?
          next if target.match?(/\A(?:https?:|mailto:)/i)
          next if target.start_with?('#')

          resolved = resolve_link_target(full_path, raw_target, root)
          next if resolved

          resolved_path = if target.start_with?('/')
                           Pathname.new(root).join(target.sub(%r{\A/+}, ''))
                         elsif target.end_with?('.md')
                           full_path.dirname.join(target)
                         else
                           full_path.dirname.join(target)
                         end
          errors << {
            file: rel_path,
            line: line_number,
            target: raw_target,
            resolved_path: resolved_path.to_s,
            reason: 'target does not resolve'
          }
        end
      end
    end
    errors
  end

  def normalize_index_line(line)
    line.to_s.encode('UTF-8', invalid: :replace, undef: :replace)
  end

  def normalize_front_matter_status(text)
    text.to_s.encode('UTF-8', invalid: :replace, undef: :replace).gsub(/^status:\s*[^\n]+$/m, 'status: STATUS')
  end

  def normalized_log_prefix(text)
    text.to_s.encode('UTF-8', invalid: :replace, undef: :replace).sub(/\s*\z/, '')
  end

  def promotion_diff_errors(root)
    errors = []
    changed_files = Open3.capture3('git', '-C', root, 'diff', '--cached', '--name-only', 'HEAD')[0].split("\n").reject(&:empty?)

    changed_files.each do |rel_path|
      next if rel_path == 'index.md' || rel_path == 'log.md' || rel_path == 'registry/sources.yaml' || rel_path == 'registry/pages.yaml' || rel_path == 'registry/claims.yaml'
      next if rel_path =~ %r{\Awiki/source-summaries/.+\.md\z}
      next if rel_path =~ %r{\Awiki/(concepts|theory|strategies|platforms)/.+\.md\z}

      errors << "disallowed file changed in promotion diff: #{rel_path}"
    end

    changed_files.each do |rel_path|
      full_path = Pathname.new(root).join(rel_path)
      head_text = git_blob_text(root, 'HEAD', rel_path)
      staged_text = git_blob_text(root, :index, rel_path)
      if head_text.nil? && staged_text.nil?
        errors << "promotion diff cannot read HEAD or staged content for #{rel_path}"
        next
      end

      case rel_path
      when 'registry/sources.yaml'
        if head_text.nil? || staged_text.nil?
          errors << "registry/sources.yaml must exist in both HEAD and the staged index"
          next
        end
        head = YAML.load(head_text)
        staged = YAML.load(staged_text)
        head_rows = head['sources']
        staged_rows = staged['sources']
        if head_rows.length != staged_rows.length
          errors << "registry/sources.yaml changed record count"
          next
        end
        head_map = head_rows.to_h { |row| [row['source_id'], row] }
        staged_map = staged_rows.to_h { |row| [row['source_id'], row] }
        head_map.each do |source_id, old_row|
          new_row = staged_map[source_id]
          unless new_row
            errors << "registry/sources.yaml removed source #{source_id}"
            next
          end
          diff_keys = (old_row.keys | new_row.keys).reject { |key| key == 'status' }
          diff_keys.each do |key|
            next if old_row[key] == new_row[key]
            errors << "registry/sources.yaml changed disallowed field #{key} for source #{source_id}"
          end
        end
      when 'registry/pages.yaml'
        if head_text.nil? || staged_text.nil?
          errors << "registry/pages.yaml must exist in both HEAD and the staged index"
          next
        end
        head = YAML.load(head_text)
        staged = YAML.load(staged_text)
        head_rows = head['pages']
        staged_rows = staged['pages']
        if head_rows.length != staged_rows.length
          errors << "registry/pages.yaml changed record count"
          next
        end
        head_map = head_rows.to_h { |row| [row['page_id'], row] }
        staged_map = staged_rows.to_h { |row| [row['page_id'], row] }
        head_map.each do |page_id, old_row|
          new_row = staged_map[page_id]
          unless new_row
            errors << "registry/pages.yaml removed page #{page_id}"
            next
          end
          diff_keys = (old_row.keys | new_row.keys).reject { |key| key == 'status' }
          diff_keys.each do |key|
            next if old_row[key] == new_row[key]
            errors << "registry/pages.yaml changed disallowed field #{key} for page #{page_id}"
          end
        end
      when 'registry/claims.yaml'
        if head_text.nil? || staged_text.nil?
          errors << "registry/claims.yaml must exist in both HEAD and the staged index"
          next
        end
        head = YAML.load(head_text)
        staged = YAML.load(staged_text)
        head_rows = head['claims']
        staged_rows = staged['claims']
        if head_rows.length != staged_rows.length
          errors << "registry/claims.yaml changed record count"
          next
        end
        head_map = head_rows.to_h { |row| [row['claim_id'], row] }
        staged_map = staged_rows.to_h { |row| [row['claim_id'], row] }
        head_map.each do |claim_id, old_row|
          new_row = staged_map[claim_id]
          unless new_row
            errors << "registry/claims.yaml removed claim #{claim_id}"
            next
          end
          diff_keys = (old_row.keys | new_row.keys).reject { |key| key == 'status' }
          diff_keys.each do |key|
            next if old_row[key] == new_row[key]
            errors << "registry/claims.yaml changed disallowed field #{key} for claim #{claim_id}"
          end
        end
      when 'index.md'
        if head_text.nil? || staged_text.nil?
          errors << 'index.md must exist in both HEAD and the staged index'
          next
        end
        head_entries = head_text.lines.map { |line| normalize_index_line(line) }
        staged_entries = staged_text.lines.map { |line| normalize_index_line(line) }
        if head_entries.length != staged_entries.length
          errors << 'index.md contains disallowed non-status changes'
          next
        end

        head_entries.zip(staged_entries).each_with_index do |(head_line, staged_line), index|
          next if head_line == staged_line
          if head_line.match?(/\A-\s+/) && staged_line.match?(/\A-\s+/)
            head_status = head_line[/`([^`]+)`\s*\z/, 1]
            staged_status = staged_line[/`([^`]+)`\s*\z/, 1]
            head_prefix = head_line.sub(/\s+—\s+`[^`]+`\s*\z/, '')
            staged_prefix = staged_line.sub(/\s+—\s+`[^`]+`\s*\z/, '')
            next if head_prefix == staged_prefix && head_status && staged_status && head_status != staged_status && head_line.sub(/`[^`]+`\s*\z/, '`STATUS`') == staged_line.sub(/`[^`]+`\s*\z/, '`STATUS`')
          end

          errors << "index.md contains disallowed non-status changes on entry #{index + 1}"
          break
        end
      when 'log.md'
        if head_text.nil? || staged_text.nil?
          errors << 'log.md must exist in both HEAD and the staged index'
          next
        end
        head_norm = normalized_log_prefix(head_text)
        staged_norm = normalized_log_prefix(staged_text)
        errors << 'log.md contains disallowed historical rewrites' unless staged_norm.start_with?(head_norm)
      else
        if rel_path =~ %r{\Awiki/source-summaries/.+\.md\z} || rel_path =~ %r{\Awiki/(concepts|theory|strategies|platforms)/.+\.md\z}
          if head_text.nil? || staged_text.nil?
            errors << "#{rel_path} must exist in both HEAD and the staged index"
            next
          end
          head_fm, head_body = parse_front_matter(head_text, rel_path)
          staged_fm, staged_body = parse_front_matter(staged_text, rel_path)
          unless head_body == staged_body
            errors << "#{rel_path} body changed outside front matter status"
          end
          diff_keys = (head_fm.keys | staged_fm.keys).reject { |key| key == 'status' }
          diff_keys.each do |key|
            next if head_fm[key] == staged_fm[key]
            errors << "#{rel_path} changed disallowed front matter field #{key}"
          end
        end
      end
    end

    errors
  end

  def governed_markdown_files(root)
    root_path = Pathname.new(root)
    files = []
    GOVERNED_MARKDOWN_ROOTS.each do |rel|
      files << rel if root_path.join(rel).exist?
    end
    GOVERNED_MARKDOWN_DIRS.each do |dir|
      Dir.glob(root_path.join(dir, '**', '*.md')).each do |path|
        files << Pathname.new(path).relative_path_from(root_path).to_s
      end
    end
    files.uniq
  end
end
