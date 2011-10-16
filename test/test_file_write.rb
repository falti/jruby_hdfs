require 'helper'
require 'hdfs'

class TestFileRead < MiniTest::Unit::TestCase
  attr_reader :hadoop, :testfile_remote
  
  def setup
    @hadoop_home=ENV["HADOOP_HOME"]
    @hadoop="#{@hadoop_home}/bin/hadoop"
    
    @testfile_remote = "/#{File.basename(__FILE__)}"
    
  end
  
  def _teardown
    %x[#{hadoop} fs -rm #{testfile_remote} > /dev/null 2>&1]
  end
  
  def test_file_write_to_new_file
    Hdfs::File.open(testfile_remote, "w") do |f|
      f.write "TEST"
    end
    
    assert_equal "TEST", Hdfs::File.new(testfile_remote).read
  end
end
