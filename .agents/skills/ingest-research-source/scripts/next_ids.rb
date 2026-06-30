#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'yaml'

require_relative 'ingestion_validation'

options = {
  root: IngestionValidation.repo_root(__dir__),
  registry_inspection_only: false
}

OptionParser.new do |opts|
  opts.banner = 'Usage: next_ids.rb --capture-report CAPTURE_REPORT.md [--root REPO_ROOT] [--registry-inspection-only]'
  opts.on('--capture-report PATH', 'Validated capture report markdown file') { |value| options[:capture_report] = value }
  opts.on('--root PATH', 'Repository root') { |value| options[:root] = value }
  opts.on('--registry-inspection-only', 'Print next IDs without authorizing ingestion; do not use for source ingestion') do
    options[:registry_inspection_only] = true
  end
end.parse!

if options[:capture_report].nil? && !options[:registry_inspection_only]
  abort('ERROR: --capture-report is required for source-ingestion ID allocation')
end

unless options[:registry_inspection_only]
  errors, = IngestionValidation.validate_capture_report_path(options[:capture_report], base_dir: options[:root], require_playbook: true)
  unless errors.empty?
    warn('ERROR: capture report validation failed')
    errors.each { |message| warn("ERROR: #{message}") }
    exit 1
  end
else
  warn('WARNING: --registry-inspection-only bypasses capture-report validation and does not authorize ingestion')
end

def load_yaml(path)
  YAML.load_file(path)
rescue StandardError => e
  abort("ERROR: malformed YAML in #{path}: #{e.message}")
end

def numeric_suffix(id, prefix)
  match = id.match(/\A#{Regexp.escape(prefix)}-(\d+)\z/)
  return nil unless match

  match[1].to_i
end

def next_prefixed_id(ids, prefix)
  numbers = ids.map { |id| numeric_suffix(id, prefix) }.compact
  format("%s-%04d", prefix, numbers.max.to_i + 1)
end

def assert_unique_ids!(ids, kind)
  duplicates = ids.group_by { |id| id }.select { |_, values| values.length > 1 }.keys
  return if duplicates.empty?

  abort("ERROR: duplicate #{kind} IDs found: #{duplicates.join(', ')}")
end

sources = load_yaml(File.join(options[:root], 'registry/sources.yaml'))['sources']
pages = load_yaml(File.join(options[:root], 'registry/pages.yaml'))['pages']
claims = load_yaml(File.join(options[:root], 'registry/claims.yaml'))['claims']

source_ids = sources.map { |row| row['source_id'] }
page_ids = pages.map { |row| row['page_id'] }
claim_ids = claims.map { |row| row['claim_id'] }

assert_unique_ids!(source_ids, 'source')
assert_unique_ids!(page_ids, 'page')
assert_unique_ids!(claim_ids, 'claim')

summary_page_ids = page_ids.select { |id| id.to_s.start_with?('SOURCE-SUMMARY-') }

puts "source_id=#{next_prefixed_id(source_ids, 'SRC')}"
puts "page_id=#{next_prefixed_id(summary_page_ids, 'SOURCE-SUMMARY')}"
puts "claim_id=#{next_prefixed_id(claim_ids, 'CLM')}"
