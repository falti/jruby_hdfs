require 'helper'
require 'hdfs'

class TestFileClassMethods < MiniTest::Unit::TestCase
  def test_respond_to_file_methods
    [:exists?, :exist?, :file?, :directory?, :chardev?, :blockdev?, :executable?, :executable_real?].each do |m|
      assert Hdfs::File.respond_to? m, "Does not respond to #{m}"
    end
  end
  
  def test_directory
    assert Hdfs::File.directory? "/"
  end
  
  def test_always_false_test
    [:chardev?, :blockdev?, :executable?, :executable_real?].each do |m|
      assert ! Hdfs::File.send(m, ".")
    end
    
  end
end
