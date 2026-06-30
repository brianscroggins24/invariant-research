# frozen_string_literal: true

require 'fileutils'
require 'minitest/autorun'
require 'open3'
require 'tmpdir'
require 'shellwords'

require_relative '../.agents/skills/ingest-research-source/scripts/ingestion_validation'

class IngestionValidationTest < Minitest::Test
  ROOT = File.expand_path('..', __dir__)

  def write_file(root, relative_path, content)
    path = File.join(root, relative_path)
    FileUtils.mkdir_p(File.dirname(path))
    File.write(path, content)
  end

  def with_temp_dir
    Dir.mktmpdir('ingestion-validation-test') do |dir|
      yield dir
    end
  end

  def with_git_repo
    with_temp_dir do |dir|
      assert system('git', '-C', dir, 'init', '-q')
      assert system('git', '-C', dir, 'config', 'user.name', 'Test User')
      assert system('git', '-C', dir, 'config', 'user.email', 'test@example.com')
      yield dir
    end
  end

  def baseline_repo_files
    {
      'registry/sources.yaml' => <<~YAML,
        sources:
          - source_id: SRC-0001
            title: Example Source
            source_type: article
            version: 1
            status: pending-ingestion
            local_path: raw/sources/SRC-0001-example.md
            content_hash: abc123
            publication_date: 2024-01-01
            retrieved_at: 2024-01-02
            original_location: https://example.com/article
            notes: baseline record
      YAML
      'registry/pages.yaml' => <<~YAML,
        pages:
          - page_id: CONCEPT-0001
            title: Example Page
            page_type: concept
            status: review-required
            path: wiki/concepts/example.md
            created_at: 2024-01-01
            updated_at: 2024-01-01
            sources: []
            related_pages: []
      YAML
      'registry/claims.yaml' => <<~YAML,
        claims: []
      YAML
      'index.md' => <<~MD,
        - [Example Page](wiki/concepts/example.md) — `review-required`
      MD
      'log.md' => <<~MD,
        - 2024-01-01 baseline entry
      MD
      'wiki/concepts/example.md' => <<~MD
        ---
        page_id: CONCEPT-0001
        title: Example Page
        page_type: concept
        status: review-required
        created_at: 2024-01-01
        updated_at: 2024-01-01
        sources: []
        related_pages: []
        ---

        Example body.
      MD
    }
  end

  def commit_baseline_repo(root)
    baseline_repo_files.each do |relative_path, content|
      write_file(root, relative_path, content)
    end
    assert system('git', '-C', root, 'add', '.')
    assert system('git', '-C', root, 'commit', '-q', '-m', 'baseline')
  end

  def stage_all(root)
    assert system('git', '-C', root, 'add', '.')
  end

  def run_next_ids(root, *args, chdir: root)
    script = File.join(ROOT, '.agents/skills/ingest-research-source/scripts/next_ids.rb')
    Open3.capture3(*(['ruby', script] + args), chdir: chdir)
  end

  def capture_report_text(artifact_path:, artifact_exists:, artifact_complete:, artifact_inspectable:, failure_reason: '', capture_method: 'local file', canonical_url: 'https://example.com/source', capture_date: '2024-01-01')
    <<~MD
      ---
      artifact_path: #{artifact_path}
      artifact_exists: #{artifact_exists}
      artifact_complete: #{artifact_complete}
      artifact_inspectable: #{artifact_inspectable}
      capture_method: #{capture_method}
      canonical_url: #{canonical_url}
      capture_date: #{capture_date}
      failure_reason: #{failure_reason}
      ---

      # Capture Report
    MD
  end

  def test_capture_report_passes_when_complete
    with_temp_dir do |dir|
      artifact = File.join(dir, 'artifact.md')
      File.write(artifact, "complete")
      report = {
        'artifact_path' => artifact,
        'artifact_exists' => true,
        'artifact_complete' => true,
        'artifact_inspectable' => true,
        'capture_method' => 'local file',
        'canonical_url' => 'https://example.com',
        'capture_date' => '2024-01-01',
        'failure_reason' => '',
        'content_type' => 'text/markdown',
        'page_count' => 1,
        'byte_count' => File.size(artifact)
      }

      assert_empty IngestionValidation.capture_report_errors(report, base_dir: dir)
    end
  end

  def test_capture_report_missing_artifact_fails
    with_temp_dir do |dir|
      report = {
        'artifact_path' => File.join(dir, 'missing.md'),
        'artifact_exists' => false,
        'artifact_complete' => false,
        'artifact_inspectable' => false,
        'capture_method' => 'local file',
        'canonical_url' => 'https://example.com',
        'capture_date' => '2024-01-01',
        'failure_reason' => 'missing artifact'
      }

      refute_empty IngestionValidation.capture_report_errors(report, base_dir: dir)
    end
  end

  def test_capture_report_incomplete_fails
    with_temp_dir do |dir|
      artifact = File.join(dir, 'artifact.md')
      File.write(artifact, "partial")
      report = {
        'artifact_path' => artifact,
        'artifact_exists' => true,
        'artifact_complete' => false,
        'artifact_inspectable' => true,
        'capture_method' => 'local file',
        'canonical_url' => 'https://example.com',
        'capture_date' => '2024-01-01',
        'failure_reason' => 'partial capture'
      }

      refute_empty IngestionValidation.capture_report_errors(report, base_dir: dir)
    end
  end

  def test_capture_report_uninspectable_fails
    with_temp_dir do |dir|
      artifact = File.join(dir, 'artifact.md')
      File.write(artifact, "uninspectable")
      report = {
        'artifact_path' => artifact,
        'artifact_exists' => true,
        'artifact_complete' => true,
        'artifact_inspectable' => false,
        'capture_method' => 'local file',
        'canonical_url' => 'https://example.com',
        'capture_date' => '2024-01-01',
        'failure_reason' => 'encrypted capture'
      }

      refute_empty IngestionValidation.capture_report_errors(report, base_dir: dir)
    end
  end

  def test_version_validation_accepts_matching_arxiv_v2
    source = {
      'source_id' => 'SRC-0005',
      'version' => 2,
      'notes' => 'captured artifact is arXiv v2 dated 2016-06-10.',
      'original_location' => 'https://arxiv.org/pdf/1606.02825v2'
    }

    assert_empty IngestionValidation.version_conflicts_for_source(source, source_by_id: { 'SRC-0005' => source })
  end

  def test_version_validation_rejects_version_mismatch
    source = {
      'source_id' => 'SRC-0005',
      'version' => 1,
      'notes' => 'captured artifact is arXiv v2 dated 2016-06-10.',
      'original_location' => 'https://arxiv.org/pdf/1606.02825v2'
    }

    refute_empty IngestionValidation.version_conflicts_for_source(source, source_by_id: { 'SRC-0005' => source })
  end

  def test_version_validation_ignores_absent_explicit_version
    source = {
      'source_id' => 'SRC-0002',
      'version' => 1,
      'notes' => 'regular capture without explicit version marker.',
      'original_location' => 'https://example.com/source'
    }

    assert_empty IngestionValidation.version_conflicts_for_source(source, source_by_id: { 'SRC-0002' => source })
  end

  def test_official_docs_date_validation_allows_empty_publication_date
    source = {
      'source_id' => 'SRC-0007',
      'source_type' => 'official-documentation',
      'publication_date' => '',
      'retrieved_at' => '2024-01-02',
      'notes' => 'The official Markdown captures did not expose page-level publication dates or last-updated dates.'
    }

    assert_empty IngestionValidation.source_date_errors(source)
  end

  def test_official_docs_date_validation_rejects_invented_publication_date
    source = {
      'source_id' => 'SRC-0007',
      'source_type' => 'official-documentation',
      'publication_date' => '2024-01-02',
      'retrieved_at' => '2024-01-02',
      'notes' => 'The official Markdown captures did not expose page-level publication dates or last-updated dates.'
    }

    refute_empty IngestionValidation.source_date_errors(source)
  end

  def test_academic_paper_date_validation_accepts_supported_publication_date
    source = {
      'source_id' => 'SRC-0005',
      'source_type' => 'research-paper',
      'publication_date' => '2016-06-10',
      'retrieved_at' => '2024-01-02',
      'notes' => 'captured artifact is arXiv v2 dated 2016-06-10.'
    }

    assert_empty IngestionValidation.source_date_errors(source)
  end

  def test_active_source_with_reviewed_summary_passes
    source = { 'source_id' => 'SRC-0001', 'status' => 'active' }
    page = {
      'page_id' => 'SOURCE-SUMMARY-0001',
      'page_type' => 'source-summary',
      'status' => 'reviewed',
      'source_id' => 'SRC-0001',
      'path' => 'wiki/source-summaries/example.md'
    }

    with_temp_dir do |dir|
      write_file(dir, 'wiki/source-summaries/example.md', <<~MD)
        ---
        page_id: SOURCE-SUMMARY-0001
        title: Example Summary
        page_type: source-summary
        status: reviewed
        source_id: SRC-0001
        sources: []
        related_pages: []
        ---

        Example summary body.
      MD

      assert_empty IngestionValidation.source_dependency_errors([source], [page], [], root: dir)
    end
  end

  def test_pending_source_with_review_required_summary_passes
    source = { 'source_id' => 'SRC-0001', 'status' => 'pending-ingestion' }
    page = {
      'page_id' => 'SOURCE-SUMMARY-0001',
      'page_type' => 'source-summary',
      'status' => 'review-required',
      'path' => 'wiki/source-summaries/example.md'
    }

    with_temp_dir do |dir|
      write_file(dir, 'registry/pages.yaml', <<~YAML)
        pages:
          - page_id: SOURCE-SUMMARY-0001
            title: Example Summary
            page_type: source-summary
            status: review-required
            path: wiki/source-summaries/example.md
      YAML
      write_file(dir, 'wiki/source-summaries/example.md', <<~MD)
        ---
        page_id: SOURCE-SUMMARY-0001
        title: Example Summary
        page_type: source-summary
        status: review-required
        source_id: SRC-0001
        sources: []
        related_pages: []
        ---

        Example summary body.
      MD

      assert_empty IngestionValidation.source_dependency_errors([source], [page], [], root: dir)
    end
  end

  def test_active_source_without_summary_fails
    source = { 'source_id' => 'SRC-0001', 'status' => 'active' }

    refute_empty IngestionValidation.source_dependency_errors([source], [], [], root: ROOT)
  end

  def test_active_source_with_review_required_summary_fails
    source = { 'source_id' => 'SRC-0001', 'status' => 'active' }
    page = {
      'page_id' => 'SOURCE-SUMMARY-0001',
      'page_type' => 'source-summary',
      'status' => 'review-required',
      'source_id' => 'SRC-0001',
      'path' => 'wiki/source-summaries/example.md'
    }

    with_temp_dir do |dir|
      write_file(dir, 'wiki/source-summaries/example.md', <<~MD)
        ---
        page_id: SOURCE-SUMMARY-0001
        title: Example Summary
        page_type: source-summary
        status: review-required
        source_id: SRC-0001
        sources: []
        related_pages: []
        ---

        Example summary body.
      MD

      refute_empty IngestionValidation.source_dependency_errors([source], [page], [], root: dir)
    end
  end

  def test_reviewed_summary_on_pending_source_fails
    source = { 'source_id' => 'SRC-0001', 'status' => 'pending-ingestion' }
    page = {
      'page_id' => 'SOURCE-SUMMARY-0001',
      'page_type' => 'source-summary',
      'status' => 'reviewed',
      'path' => 'wiki/source-summaries/example.md'
    }

    with_temp_dir do |dir|
      write_file(dir, 'wiki/source-summaries/example.md', <<~MD)
        ---
        page_id: SOURCE-SUMMARY-0001
        title: Example Summary
        page_type: source-summary
        status: reviewed
        source_id: SRC-0001
        sources: []
        related_pages: []
        ---

        Example summary body.
      MD

      refute_empty IngestionValidation.source_dependency_errors([source], [page], [], root: dir)
    end
  end

  def test_multiple_summaries_for_one_active_source_fail
    source = { 'source_id' => 'SRC-0001', 'status' => 'active' }
    pages = [
      {
        'page_id' => 'SOURCE-SUMMARY-0001',
        'page_type' => 'source-summary',
        'status' => 'reviewed',
        'path' => 'wiki/source-summaries/a.md'
      },
      {
        'page_id' => 'SOURCE-SUMMARY-0002',
        'page_type' => 'source-summary',
        'status' => 'reviewed',
        'path' => 'wiki/source-summaries/b.md'
      }
    ]

    with_temp_dir do |dir|
      write_file(dir, 'wiki/source-summaries/a.md', <<~MD)
        ---
        page_id: SOURCE-SUMMARY-0001
        title: Example Summary A
        page_type: source-summary
        status: reviewed
        source_id: SRC-0001
        sources: []
        related_pages: []
        ---

        Example summary body.
      MD
      write_file(dir, 'wiki/source-summaries/b.md', <<~MD)
        ---
        page_id: SOURCE-SUMMARY-0002
        title: Example Summary B
        page_type: source-summary
        status: reviewed
        source_id: SRC-0001
        sources: []
        related_pages: []
        ---

        Example summary body.
      MD

      refute_empty IngestionValidation.source_dependency_errors([source], pages, [], root: dir)
    end
  end

  def test_registry_frontmatter_source_disagreement_fails
    source = { 'source_id' => 'SRC-0001', 'status' => 'active' }
    page = {
      'page_id' => 'SOURCE-SUMMARY-0001',
      'page_type' => 'source-summary',
      'status' => 'reviewed',
      'source_id' => 'SRC-9999',
      'path' => 'wiki/source-summaries/example.md'
    }

    with_temp_dir do |dir|
      write_file(dir, 'registry/pages.yaml', <<~YAML)
        pages:
          - page_id: SOURCE-SUMMARY-0001
            title: Example Summary
            page_type: source-summary
            status: reviewed
            source_id: SRC-9999
            path: wiki/source-summaries/example.md
      YAML
      write_file(dir, 'wiki/source-summaries/example.md', <<~MD)
        ---
        page_id: SOURCE-SUMMARY-0001
        title: Example Summary
        page_type: source-summary
        status: reviewed
        source_id: SRC-0001
        sources: []
        related_pages: []
        ---

        Example summary body.
      MD

      refute_empty IngestionValidation.source_dependency_errors([source], [page], [], root: dir)
    end
  end

  def test_missing_source_id_in_frontmatter_fails
    source = { 'source_id' => 'SRC-0001', 'status' => 'active' }
    page = {
      'page_id' => 'SOURCE-SUMMARY-0001',
      'page_type' => 'source-summary',
      'status' => 'reviewed',
      'path' => 'wiki/source-summaries/example.md'
    }

    with_temp_dir do |dir|
      write_file(dir, 'wiki/source-summaries/example.md', <<~MD)
        ---
        page_id: SOURCE-SUMMARY-0001
        title: Example Summary
        page_type: source-summary
        status: reviewed
        sources: []
        related_pages: []
        ---

        Example summary body.
      MD

      refute_empty IngestionValidation.source_dependency_errors([source], [page], [], root: dir)
    end
  end

  def test_reviewed_claim_on_inactive_source_fails
    source = { 'source_id' => 'SRC-0001', 'status' => 'superseded' }
    claim = {
      'claim_id' => 'CLM-0001',
      'status' => 'reviewed',
      'sources' => [{ 'source_id' => 'SRC-0001', 'locator' => 'p. 1' }],
      'related_pages' => []
    }

    refute_empty IngestionValidation.source_dependency_errors([source], [], [claim], root: ROOT)
  end

  def test_valid_sibling_link_passes
    with_temp_dir do |dir|
      write_file(dir, 'wiki/source-summaries/a.md', "[B](b.md)\n")
      write_file(dir, 'wiki/source-summaries/b.md', "target\n")

      assert_empty IngestionValidation.validate_markdown_links(['wiki/source-summaries/a.md'], root: dir)
    end
  end

  def test_valid_parent_relative_link_passes
    with_temp_dir do |dir|
      write_file(dir, 'wiki/concepts/a.md', "[B](../source-summaries/b.md)\n")
      write_file(dir, 'wiki/source-summaries/b.md', "target\n")

      assert_empty IngestionValidation.validate_markdown_links(['wiki/concepts/a.md'], root: dir)
    end
  end

  def test_broken_sibling_link_fails
    with_temp_dir do |dir|
      write_file(dir, 'wiki/source-summaries/SRC-0005.md', "[broken](wiki/source-summaries/SRC-0004-the-math-needed-for-trading-on-polymarket.md)\n")

      errors = IngestionValidation.validate_markdown_links(['wiki/source-summaries/SRC-0005.md'], root: dir)
      refute_empty errors
    end
  end

  def test_external_url_is_ignored
    with_temp_dir do |dir|
      write_file(dir, 'wiki/source-summaries/a.md', "[External](https://example.com)\n")

      assert_empty IngestionValidation.validate_markdown_links(['wiki/source-summaries/a.md'], root: dir)
    end
  end

  def test_missing_target_fails
    with_temp_dir do |dir|
      write_file(dir, 'wiki/source-summaries/a.md', "[Missing](missing.md)\n")

      refute_empty IngestionValidation.validate_markdown_links(['wiki/source-summaries/a.md'], root: dir)
    end
  end

  def test_status_only_source_promotion_passes
    with_git_repo do |dir|
      commit_baseline_repo(dir)
      write_file(dir, 'registry/sources.yaml', <<~YAML)
        sources:
          - source_id: SRC-0001
            title: Example Source
            source_type: article
            version: 1
            status: active
            local_path: raw/sources/SRC-0001-example.md
            content_hash: abc123
            publication_date: 2024-01-01
            retrieved_at: 2024-01-02
            original_location: https://example.com/article
            notes: baseline record
      YAML
      stage_all(dir)

      assert_empty IngestionValidation.promotion_diff_errors(dir)
    end
  end

  def test_promotion_reads_staged_content_not_worktree
    with_git_repo do |dir|
      commit_baseline_repo(dir)
      write_file(dir, 'registry/sources.yaml', <<~YAML)
        sources:
          - source_id: SRC-0001
            title: Example Source
            source_type: article
            version: 1
            status: active
            local_path: raw/sources/SRC-0001-example.md
            content_hash: abc123
            publication_date: 2024-01-01
            retrieved_at: 2024-01-02
            original_location: https://example.com/article
            notes: baseline record
      YAML
      stage_all(dir)
      File.write(File.join(dir, 'registry/sources.yaml'), <<~YAML)
        sources:
          - source_id: SRC-0001
            title: Example Source
            source_type: article
            version: 1
            status: active
            local_path: raw/sources/SRC-0001-example.md
            content_hash: abc123
            publication_date: 2024-02-01
            retrieved_at: 2024-01-02
            original_location: https://example.com/article
            notes: baseline record
      YAML

      assert_empty IngestionValidation.promotion_diff_errors(dir)
    end
  end

  def test_status_only_synthesis_page_promotion_passes
    with_git_repo do |dir|
      commit_baseline_repo(dir)
      write_file(dir, 'registry/pages.yaml', <<~YAML)
        pages:
          - page_id: CONCEPT-0001
            title: Example Page
            page_type: concept
            status: reviewed
            path: wiki/concepts/example.md
            created_at: 2024-01-01
            updated_at: 2024-01-01
            sources: []
            related_pages: []
      YAML
      write_file(dir, 'wiki/concepts/example.md', <<~MD)
        ---
        page_id: CONCEPT-0001
        title: Example Page
        page_type: concept
        status: reviewed
        created_at: 2024-01-01
        updated_at: 2024-01-01
        sources: []
        related_pages: []
        ---

        Example body.
      MD
      write_file(dir, 'index.md', <<~MD)
        - [Example Page](wiki/concepts/example.md) — `reviewed`
      MD
      write_file(dir, 'log.md', <<~MD)
        - 2024-01-01 baseline entry
        - 2024-01-02 promoted Example Page
      MD
      stage_all(dir)

      assert_empty IngestionValidation.promotion_diff_errors(dir)
    end
  end

  def test_index_status_only_change_passes
    with_git_repo do |dir|
      commit_baseline_repo(dir)
      index_text = File.read(File.join(dir, 'index.md'))
      write_file(dir, 'index.md', index_text.sub('`review-required`', '`reviewed`'))
      stage_all(dir)

      assert_empty IngestionValidation.promotion_diff_errors(dir)
    end
  end

  def test_index_page_id_change_fails
    with_git_repo do |dir|
      commit_baseline_repo(dir)
      write_file(dir, 'index.md', <<~MD)
        # invariant-research

        Minimal landing page for the research wiki.

        ## Sources

        - `SRC-9999` — [LLM Wiki initial capture](raw/sources/SRC-0001-karpathy-llm-wiki.md) — `superseded`
        - `SRC-0002` — [LLM Wiki](raw/sources/SRC-0002-karpathy-llm-wiki.md) — `active`

        ## Knowledge Pages

        - [LLM Wiki source summary](wiki/source-summaries/SRC-0001-karpathy-llm-wiki.md) — `reviewed`
      MD
      stage_all(dir)

      refute_empty IngestionValidation.promotion_diff_errors(dir)
    end
  end

  def test_index_path_change_fails
    with_git_repo do |dir|
      commit_baseline_repo(dir)
      write_file(dir, 'index.md', <<~MD)
        # invariant-research

        Minimal landing page for the research wiki.

        ## Sources

        - `SRC-0001` — [LLM Wiki initial capture](raw/sources/changed.md) — `superseded`
        - `SRC-0002` — [LLM Wiki](raw/sources/SRC-0002-karpathy-llm-wiki.md) — `active`
      MD
      stage_all(dir)

      refute_empty IngestionValidation.promotion_diff_errors(dir)
    end
  end

  def test_index_inline_code_change_fails
    with_git_repo do |dir|
      commit_baseline_repo(dir)
      write_file(dir, 'index.md', <<~MD)
        # invariant-research

        Minimal landing page for the research wiki.

        ## Sources

        - `SRC-0009` — [LLM Wiki initial capture](raw/sources/SRC-0001-karpathy-llm-wiki.md) — `superseded`
        - `SRC-0002` — [LLM Wiki](raw/sources/SRC-0002-karpathy-llm-wiki.md) — `active`
      MD
      stage_all(dir)

      refute_empty IngestionValidation.promotion_diff_errors(dir)
    end
  end

  def test_index_prose_change_fails
    with_git_repo do |dir|
      commit_baseline_repo(dir)
      write_file(dir, 'index.md', <<~MD)
        # invariant-research

        Minimal landing page for the updated research wiki.

        ## Sources

        - `SRC-0001` — [LLM Wiki initial capture](raw/sources/SRC-0001-karpathy-llm-wiki.md) — `superseded`
        - `SRC-0002` — [LLM Wiki](raw/sources/SRC-0002-karpathy-llm-wiki.md) — `active`
      MD
      stage_all(dir)

      refute_empty IngestionValidation.promotion_diff_errors(dir)
    end
  end

  def test_source_metadata_edit_fails
    with_git_repo do |dir|
      commit_baseline_repo(dir)
      write_file(dir, 'registry/sources.yaml', <<~YAML)
        sources:
          - source_id: SRC-0001
            title: Example Source
            source_type: article
            version: 1
            status: pending-ingestion
            local_path: raw/sources/SRC-0001-example.md
            content_hash: abc123
            publication_date: 2024-02-01
            retrieved_at: 2024-01-02
            original_location: https://example.com/article
            notes: baseline record
      YAML
      stage_all(dir)

      refute_empty IngestionValidation.promotion_diff_errors(dir)
    end
  end

  def test_current_repository_active_sources_have_reviewed_summaries
    sources = IngestionValidation.load_yaml(File.join(ROOT, 'registry/sources.yaml'))['sources']
    pages = IngestionValidation.load_yaml(File.join(ROOT, 'registry/pages.yaml'))['pages']
    claims = IngestionValidation.load_yaml(File.join(ROOT, 'registry/claims.yaml'))['claims']

    errors = IngestionValidation.source_dependency_errors(sources, pages, claims, root: ROOT)
    refute errors.grep(/active source SRC-\d{4} has no reviewed source summary/).any?, errors.join("\n")
  end

  def test_synthesis_body_edit_fails
    with_git_repo do |dir|
      commit_baseline_repo(dir)
      write_file(dir, 'wiki/concepts/example.md', <<~MD)
        ---
        page_id: CONCEPT-0001
        title: Example Page
        page_type: concept
        status: review-required
        created_at: 2024-01-01
        updated_at: 2024-01-01
        sources: []
        related_pages: []
        ---

        Changed body.
      MD
      stage_all(dir)

      refute_empty IngestionValidation.promotion_diff_errors(dir)
    end
  end

  def test_appended_log_entry_passes
    with_git_repo do |dir|
      commit_baseline_repo(dir)
      write_file(dir, 'log.md', <<~MD)
        - 2024-01-01 baseline entry
        - 2024-01-02 appended entry
      MD
      stage_all(dir)

      assert_empty IngestionValidation.promotion_diff_errors(dir)
    end
  end

  def test_rewritten_historical_log_content_fails
    with_git_repo do |dir|
      commit_baseline_repo(dir)
      write_file(dir, 'log.md', <<~MD)
        - 2024-01-01 rewritten entry
      MD
      stage_all(dir)

      refute_empty IngestionValidation.promotion_diff_errors(dir)
    end
  end

  def test_next_ids_requires_capture_report
    with_git_repo do |dir|
      commit_baseline_repo(dir)
      stdout, stderr, status = run_next_ids(dir, '--root', dir)

      refute status.success?
      assert_equal '', stdout
      assert_match(/--capture-report is required/, stderr)
      refute_match(/source_id=/, stderr + stdout)
    end
  end

  def test_next_ids_rejects_failing_capture_report
    with_git_repo do |dir|
      commit_baseline_repo(dir)
      write_file(dir, 'capture-report.md', capture_report_text(
                   artifact_path: 'artifact.md',
                   artifact_exists: false,
                   artifact_complete: false,
                   artifact_inspectable: false,
                   failure_reason: 'missing artifact'
                 ))

      stdout, stderr, status = run_next_ids(dir, '--root', dir, '--capture-report', 'capture-report.md')

      refute status.success?
      assert_equal '', stdout
      assert_match(/capture report validation failed/, stderr)
      assert_match(/artifact_exists must be true/, stderr)
      refute_match(/source_id=/, stderr + stdout)
    end
  end

  def test_next_ids_missing_capture_report_file_fails
    with_git_repo do |dir|
      commit_baseline_repo(dir)
      stdout, stderr, status = run_next_ids(dir, '--root', dir, '--capture-report', 'missing-report.md')

      refute status.success?
      assert_equal '', stdout
      assert_match(/No such file or directory|missing-report\.md/, stderr)
      refute_match(/source_id=/, stderr + stdout)
    end
  end

  def test_next_ids_malformed_capture_report_fails
    with_git_repo do |dir|
      commit_baseline_repo(dir)
      write_file(dir, 'capture-report.md', "not front matter\n")
      stdout, stderr, status = run_next_ids(dir, '--root', dir, '--capture-report', 'capture-report.md')

      refute status.success?
      assert_equal '', stdout
      assert_match(/missing YAML front matter|malformed front matter/, stderr)
      refute_match(/source_id=/, stderr + stdout)
    end
  end

  def test_next_ids_accepts_valid_capture_report_and_outputs_expected_ids
    with_git_repo do |dir|
      commit_baseline_repo(dir)
      write_file(dir, 'artifact.md', 'complete')
      write_file(dir, 'capture-report.md', capture_report_text(
                   artifact_path: 'artifact.md',
                   artifact_exists: true,
                   artifact_complete: true,
                   artifact_inspectable: true,
                   failure_reason: ''
                 ))

      stdout, stderr, status = run_next_ids(dir, '--root', dir, '--capture-report', 'capture-report.md')

      assert status.success?
      assert_equal '', stderr
      assert_match(/source_id=SRC-0002/, stdout)
      assert_match(/page_id=SOURCE-SUMMARY-0001/, stdout)
      assert_match(/claim_id=CLM-0001/, stdout)
    end
  end

  def test_next_ids_registry_inspection_only_warns
    with_git_repo do |dir|
      commit_baseline_repo(dir)
      stdout, stderr, status = run_next_ids(dir, '--root', dir, '--registry-inspection-only')

      assert status.success?
      assert_match(/WARNING: --registry-inspection-only/, stderr)
      assert_match(/source_id=SRC-0002/, stdout)
    end
  end

  def test_validate_capture_report_and_next_ids_share_relative_path_semantics
    with_git_repo do |dir|
      commit_baseline_repo(dir)
      FileUtils.mkdir_p(File.join(dir, 'nested'))
      write_file(dir, 'nested/artifact.md', 'complete')
      write_file(dir, 'nested/capture-report.md', capture_report_text(
                   artifact_path: 'nested/artifact.md',
                   artifact_exists: true,
                   artifact_complete: true,
                   artifact_inspectable: true,
                   failure_reason: ''
                 ))

      validate_stdout, validate_stderr, validate_status = Open3.capture3(
        'ruby',
        File.join(ROOT, '.agents/skills/ingest-research-source/scripts/validate_capture_report.rb'),
        '--file',
        'nested/capture-report.md',
        '--root',
        dir,
        chdir: dir
      )

      assert validate_status.success?, validate_stdout + validate_stderr

      next_stdout, next_stderr, next_status = run_next_ids(dir, '--root', dir, '--capture-report', 'nested/capture-report.md')

      assert next_status.success?, next_stdout + next_stderr
      assert_match(/source_id=SRC-0002/, next_stdout)
    end
  end
end
