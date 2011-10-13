require 'rubygems'
gem 'minitest'
require 'minitest/autorun'

require "hdfs"

class TestExploration < MiniTest::Unit::TestCase
  def test_file_new
    assert_raises(Errno::ENOENT) { f = Hdfs::File.new("xxx") }
    assert_raises(Errno::ENOENT) { f = Hdfs::File.new(".") }
    
  end
end