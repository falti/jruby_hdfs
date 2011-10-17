require 'helper'
require 'hdfs'
require 'tempfile'
require 'digest/md5'

class TestFileWrite < MiniTest::Unit::TestCase
  attr_reader :hadoop, :testfile_remote
  
  def setup
    @hadoop_home=ENV["HADOOP_HOME"]
    @hadoop="#{@hadoop_home}/bin/hadoop"
    
    @testfile_remote = "/#{File.basename(__FILE__)}"
    @local_temp_file=Tempfile.new("hadoop_write_test")
    md5 = Digest::MD5.new
    max = 1024 * 1024
    1.upto(max) do |i|
      md5 << rand(max).to_s
      res = md5.finish
      @local_temp_file.write(res)
    end
    
    @local_temp_file.rewind
  end
  
  def _teardown
    @local_temp_file.close
    @local_temp_file.unlink
    %x[#{hadoop} fs -rm #{testfile_remote} > /dev/null 2>&1]
  end
  
  def test_file_write_to_new_file
    Hdfs::File.open(testfile_remote, "w") do |f|
      f.write "TEST"
    end
    
    assert_equal "TEST", Hdfs::File.new(testfile_remote).read
  end
  
  def test_file_write_to_new_file_buffered
    buffersize=8192
    expectation_hash = Digest::MD5.new
    Hdfs::File.open(testfile_remote, "w") do |f|
      buffer = ""
      while (buffer =  @local_temp_file.read(buffersize))
        f.write(buffer)
        expectation_hash.update(buffer)
      end
    end
    
    @local_temp_file.rewind
    remote_file = Hdfs::File.new(testfile_remote)
    
    buffer=""
    actual_hash = Digest::MD5.new
    while (buffer =  remote_file.read(buffersize))
      actual_hash.update(buffer)
    end
    
    assert_equal expectation_hash, actual_hash
  end
end
