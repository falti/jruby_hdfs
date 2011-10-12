require "test/unit"

require "hdfs"

class TestExploration < Test::Unit::TestCase
	def test_ls
		fs = Hdfs::Fs.new
		p = Hdfs::Path.new("/")
		
		puts fs.fs.getFileStatus(p.path).group
	end
end
