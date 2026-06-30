#!/usr/bin/env ruby
# frozen_string_literal: true

require 'digest'
require 'yaml'

require_relative 'ingestion_validation'

ROOT = IngestionValidation.repo_root(__dir__)

def error(message)
  warn("ERROR: #{message}")
end

def add_issue(condition, message, errors)
  errors << message unless condition
end

errors = []

begin
  sources = IngestionValidation.load_yaml(File.join(ROOT, 'registry/sources.yaml'))['sources']
  pages = IngestionValidation.load_yaml(File.join(ROOT, 'registry/pages.yaml'))['pages']
  claims = IngestionValidation.load_yaml(File.join(ROOT, 'registry/claims.yaml'))['claims']
rescue StandardError => e
  error(e.message)
  exit 1
end

add_issue(sources.is_a?(Array), 'registry/sources.yaml must contain a sources array', errors)
add_issue(pages.is_a?(Array), 'registry/pages.yaml must contain a pages array', errors)
add_issue(claims.is_a?(Array), 'registry/claims.yaml must contain a claims array', errors)

if errors.empty?
  duplicates = {
    'source' => sources.group_by { |row| row['source_id'] }.select { |_, values| values.length > 1 }.keys,
    'page' => pages.group_by { |row| row['page_id'] }.select { |_, values| values.length > 1 }.keys,
    'claim' => claims.group_by { |row| row['claim_id'] }.select { |_, values| values.length > 1 }.keys
  }
  duplicates.each do |kind, ids|
    add_issue(ids.empty?, "duplicate #{kind} IDs: #{ids.join(', ')}", errors)
  end
end

source_by_id = sources.to_h { |row| [row['source_id'], row] }
page_by_id = pages.to_h { |row| [row['page_id'], row] }

sources.each do |source|
  local_path = source['local_path']
  add_issue(local_path && !local_path.empty?, "source #{source['source_id']} is missing local_path", errors)
  source_path = File.join(ROOT, local_path.to_s)
  add_issue(File.exist?(source_path), "missing raw source file for #{source['source_id']}: #{local_path}", errors)
  next unless File.exist?(source_path)

  actual_hash = Digest::SHA256.file(source_path).hexdigest
  add_issue(actual_hash == source['content_hash'], "SHA-256 mismatch for #{source['source_id']}: registry=#{source['content_hash']} actual=#{actual_hash}", errors)
  errors.concat(IngestionValidation.version_conflicts_for_source(source, source_by_id: source_by_id))
  errors.concat(IngestionValidation.source_date_errors(source))
end

pages.each do |page|
  begin
    page_front_matter, = IngestionValidation.read_front_matter(File.join(ROOT, page['path'].to_s))
  rescue StandardError => e
    errors << e.message
    next
  end

  add_issue(page_front_matter['page_id'] == page['page_id'], "page ID mismatch in #{page['path']}: registry=#{page['page_id']} file=#{page_front_matter['page_id']}", errors)
  add_issue(page_front_matter['status'] == page['status'], "status mismatch for #{page['page_id']}: registry=#{page['status']} file=#{page_front_matter['status']}", errors)
end

errors.concat(IngestionValidation.source_dependency_errors(sources, pages, claims, root: ROOT))

if errors.empty?
  puts 'PASS: ingestion registry validation succeeded'
  exit 0
end

error('ingestion validation failed')
errors.each { |msg| error(msg) }
exit 1
