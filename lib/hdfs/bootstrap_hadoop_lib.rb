module Hdfs
  JAR_PATTERN_0_19="hadoop-*-core.jar"
  JAR_PATTERN_0_20="hadoop-core-*.jar"
  
  if RUBY_PLATFORM =~ /java/
    require "java"
  elsif $VERBOSE
    warn "only for use with JRuby"
  end
  
  if ENV["HADOOP_HOME"]
    HADOOP_HOME=ENV["HADOOP_HOME"]
    Dir["#{HADOOP_HOME}/#{JAR_PATTERN_0_19}","#{HADOOP_HOME}/#{JAR_PATTERN_0_20}","#{HADOOP_HOME}/lib/*.jar"].each  do |jar|
      require jar
    end
  
    $CLASSPATH << "#{HADOOP_HOME}/conf"
  
  elsif $VERBOSE
    warn "HADOOP_HOME is not set!"
  end
end