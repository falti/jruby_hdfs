require "test/unit"

require "hdfs"

class TestExploration < Test::Unit::TestCase
	def test_file_new
		assert_raise(Errno::ENOENT) { f = Hdfs::File.new("xxx") }
		assert_raise(Errno::ENOENT) { f = Hdfs::File.new(".") }
		
	end
end
