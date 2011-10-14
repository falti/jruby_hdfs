#!/usr/bin/env ruby
module Hdfs
  
  private
  
  class Path
    import org.apache.hadoop.fs.Path
    
    attr_reader :path
    
    def initialize(p)
      @path=Path.new(p)
    end
    
  end
  
end