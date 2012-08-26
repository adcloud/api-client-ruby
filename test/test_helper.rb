require 'simplecov'
SimpleCov.start 'rails'

require 'rubygems'
require 'bundler'
require 'minitest/mock'
require 'minitest/autorun'
require "minitest/reporters"
require 'webmock/minitest'
require 'mocha'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

MiniTest::Reporters.use! MiniTest::Reporters::ProgressReporter.new

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'adcloud'
