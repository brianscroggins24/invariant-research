#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

require_relative 'ingestion_validation'

options = {
  root: IngestionValidation.repo_root(__dir__)
}

OptionParser.new do |opts|
  opts.banner = 'Usage: validate_promotion.rb [--root REPO_ROOT]'
  opts.on('--root PATH', 'Repository root') { |value| options[:root] = value }
end.parse!

errors = IngestionValidation.promotion_diff_errors(options[:root])

if errors.empty?
  puts 'PASS: promotion diff validation succeeded'
  exit 0
end

warn('ERROR: promotion diff validation failed')
errors.each { |message| warn("ERROR: #{message}") }
exit 1
