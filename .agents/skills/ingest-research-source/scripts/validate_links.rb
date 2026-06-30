#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

require_relative 'ingestion_validation'

options = {
  root: IngestionValidation.repo_root(__dir__)
}

paths = OptionParser.new do |opts|
  opts.banner = 'Usage: validate_links.rb [--root REPO_ROOT] [FILES...]'
  opts.on('--root PATH', 'Repository root') { |value| options[:root] = value }
end.parse!

paths = IngestionValidation.governed_markdown_files(options[:root]) if paths.empty?

errors = IngestionValidation.validate_markdown_links(paths, root: options[:root])

if errors.empty?
  puts 'PASS: markdown link validation succeeded'
  exit 0
end

warn('ERROR: markdown link validation failed')
errors.each do |error|
  warn("ERROR: #{error[:file]}:#{error[:line]} target=#{error[:target]} resolved=#{error[:resolved_path]} reason=#{error[:reason]}")
end
exit 1
