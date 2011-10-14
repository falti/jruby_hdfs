if RUBY_PLATFORM =~ /java/
  require "java"
elsif $VERBOSE
  warn "only for use with JRuby"
end

if ENV["HADOOP_HOME"]
  HADOOP_HOME=ENV["HADOOP_HOME"]
  Dir["#{HADOOP_HOME}/hadoop-core*.jar","#{HADOOP_HOME}/lib/*.jar"].each  do |jar|
    require jar
  end
  
  $CLASSPATH << "#{HADOOP_HOME}/conf"
  
elsif $VERBOSE
  warn "HADOOP_HOME is not set!"
end

require "hdfs/file_system"
require "hdfs/file"
require "hdfs/path"

module Hdfs
  
  @fs=FileSystem.new
  
  def self.fs
    @fs
  end
  
end