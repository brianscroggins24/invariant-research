#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

require_relative 'ingestion_validation'

options = {
  root: IngestionValidation.repo_root(__dir__),
  require_playbook: true
}

OptionParser.new do |opts|
  opts.banner = 'Usage: validate_capture_report.rb --file CAPTURE_REPORT.md [--root REPO_ROOT] [--allow-legacy]'
  opts.on('--file PATH', 'Capture report markdown file') { |value| options[:file] = value }
  opts.on('--root PATH', 'Repository root used to resolve relative artifact paths') { |value| options[:root] = value }
  opts.on('--allow-legacy', 'Allow legacy capture reports outside new-ingestion ID allocation') do
    options[:require_playbook] = false
  end
end.parse!

abort('ERROR: --file is required') unless options[:file]

errors, = IngestionValidation.validate_capture_report_path(options[:file], base_dir: options[:root], require_playbook: options[:require_playbook])

if errors.empty?
  puts 'PASS: capture report validation succeeded'
  exit 0
end

warn('ERROR: capture report validation failed')
errors.each { |message| warn("ERROR: #{message}") }
exit 1
