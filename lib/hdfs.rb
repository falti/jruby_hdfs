require "hdfs/bootstrap_hadoop_lib"
require "hdfs/version"
require "hdfs/file_system"
require "hdfs/file"
require "hdfs/path"

module Hdfs
  
  def self.fs
      @@fs ||= FileSystem.new
  end
  
end