#!/usr/bin/env ruby
# frozen_string_literal: true

require 'digest'
require 'yaml'

ROOT = File.expand_path('../../../../', __dir__)

def error(message)
  warn("ERROR: #{message}")
end

def load_yaml(path)
  YAML.load_file(path)
rescue StandardError => e
  raise StandardError, "malformed YAML in #{path}: #{e.message}"
end

def read_front_matter(path)
  text = File.binread(path).force_encoding('UTF-8')
  match = text.match(/\A---\n(.*?)\n---\n/m)
  raise StandardError, "missing YAML front matter in #{path}" unless match

  YAML.load(match[1])
rescue StandardError => e
  raise StandardError, "malformed front matter in #{path}: #{e.message}"
end

def duplicate_ids(rows, key)
  rows.group_by { |row| row[key] }.select { |_, values| values.length > 1 }.keys
end

def add_issue(condition, message, errors)
  errors << message unless condition
end

errors = []

begin
  sources = load_yaml(File.join(ROOT, 'registry/sources.yaml'))['sources']
  pages = load_yaml(File.join(ROOT, 'registry/pages.yaml'))['pages']
  claims = load_yaml(File.join(ROOT, 'registry/claims.yaml'))['claims']
rescue StandardError => e
  error(e.message)
  exit 1
end

add_issue(sources.is_a?(Array), 'registry/sources.yaml must contain a sources array', errors)
add_issue(pages.is_a?(Array), 'registry/pages.yaml must contain a pages array', errors)
add_issue(claims.is_a?(Array), 'registry/claims.yaml must contain a claims array', errors)

if errors.empty?
  duplicates = {
    'source' => duplicate_ids(sources, 'source_id'),
    'page' => duplicate_ids(pages, 'page_id'),
    'claim' => duplicate_ids(claims, 'claim_id')
  }
  duplicates.each do |kind, ids|
    add_issue(ids.empty?, "duplicate #{kind} IDs: #{ids.join(', ')}", errors)
  end
end

source_by_id = sources.to_h { |row| [row['source_id'], row] }
page_by_id = pages.to_h { |row| [row['page_id'], row] }

pages.each do |page|
  path = page['path']
  add_issue(path && !path.empty?, "page #{page['page_id']} is missing path", errors)
  add_issue(File.exist?(File.join(ROOT, path.to_s)), "missing page file for #{page['page_id']}: #{path}", errors)
end

sources.each do |source|
  local_path = source['local_path']
  add_issue(local_path && !local_path.empty?, "source #{source['source_id']} is missing local_path", errors)
  source_path = File.join(ROOT, local_path.to_s)
  add_issue(File.exist?(source_path), "missing raw source file for #{source['source_id']}: #{local_path}", errors)
  next unless File.exist?(source_path)

  if source['status'] == 'active'
    actual_hash = Digest::SHA256.file(source_path).hexdigest
    add_issue(actual_hash == source['content_hash'], "SHA-256 mismatch for #{source['source_id']}: registry=#{source['content_hash']} actual=#{actual_hash}", errors)
  end
end

pages.each do |page|
  begin
    page_body = read_front_matter(File.join(ROOT, page['path'].to_s))
  rescue StandardError => e
    errors << e.message
    next
  end

  add_issue(page_body['page_id'] == page['page_id'], "page ID mismatch in #{page['path']}: registry=#{page['page_id']} file=#{page_body['page_id']}", errors)
  add_issue(page_body['status'] == page['status'], "status mismatch for #{page['page_id']}: registry=#{page['status']} file=#{page_body['status']}", errors)
end

claims.each do |claim|
  add_issue(claim['sources'].is_a?(Array), "claim #{claim['claim_id']} must list sources", errors)
  claim['sources'].each do |source_ref|
    source_id = source_ref['source_id']
    add_issue(source_by_id.key?(source_id), "claim #{claim['claim_id']} references missing source #{source_id}", errors)
  end

  related_pages = claim['related_pages'] || []
  related_pages.each do |page_id|
    add_issue(page_by_id.key?(page_id), "claim #{claim['claim_id']} references missing related page #{page_id}", errors)
  end
end

if errors.empty?
  puts 'PASS: ingestion registry validation succeeded'
  exit 0
end

error('ingestion validation failed')
errors.each { |msg| error(msg) }
exit 1
