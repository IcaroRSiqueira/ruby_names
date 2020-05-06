# frozen_string_literal: true

require 'active_support/all'
require 'stringio'

PROJECT_ROOT = File.expand_path('..', __dir__)

Dir.glob(File.join(PROJECT_ROOT, 'lib', '*.rb')).each do |file|
 autoload File.basename(file, '.rb').camelize, file
end

RSpec.configure do |config|
end

def capture_stdout(&blk)
  old = $stdout
  $stdout = fake = StringIO.new
  blk.call
  fake.string
ensure
  $stdout = old
end

def capture_stderr(&blk)
  old = $stderr
  $stderr = fake = StringIO.new
  blk.call
  fake.string
ensure
  $stderr = old
end
