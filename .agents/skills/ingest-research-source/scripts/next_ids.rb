#!/usr/bin/env ruby
# frozen_string_literal: true

require 'yaml'

ROOT = File.expand_path('../../../../', __dir__)

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

sources = load_yaml(File.join(ROOT, 'registry/sources.yaml'))['sources']
pages = load_yaml(File.join(ROOT, 'registry/pages.yaml'))['pages']
claims = load_yaml(File.join(ROOT, 'registry/claims.yaml'))['claims']

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
