require 'rubygems'
gem 'minitest'
require 'minitest/autorun'

require "hdfs"

class TestExploration < MiniTest::Unit::TestCase
  attr_reader :hadoop, :testfile_remote
  
  def setup
    @hadoop_home=ENV["HADOOP_HOME"]
    @hadoop="#{@hadoop_home}/bin/hadoop"
    
    testfile_local = __FILE__
    @testfile_remote = "/#{File.basename(__FILE__)}"
    
    %x[#{hadoop} fs -put #{testfile_local} #{testfile_remote} > /dev/null 2>&1]
    
  end
  
  def _teardown
    %x[#{hadoop} fs -rm #{testfile_remote} > /dev/null 2>&1]
  end
  
  
  
  def test_file_new_fails_if_not_exist
    assert_raises(Errno::ENOENT) { f = Hdfs::File.new("xxx") }
  end
  
  def test_file_new_fails_for_dir
    assert_raises(Errno::ENOENT) { f = Hdfs::File.new("/") }
  end
  
  def test_file_new
    f = Hdfs::File.new(testfile_remote)
    f.close
  end
  
  def test_file_open_close
    f = Hdfs::File.new(testfile_remote)
    assert !f.closed?
    f.close
    assert f.closed?
  end

  def test_file_read
    f = Hdfs::File.new(testfile_remote)
    buffer = f.read
    assert_match /require 'rubygems'/, buffer
    f.close
  end
  
  def test_file_readlines
    f = Hdfs::File.new(testfile_remote)
    buffer = f.readlines
    assert_match /require 'rubygems'/, buffer[0]
    f.close
  end
  
  
end