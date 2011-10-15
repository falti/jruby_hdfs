module Hdfs
  
  # wrapper for the org.apache.hadoop.fs.Path
  class Path
    import org.apache.hadoop.fs.Path
    
    # reference to org.apache.hadoop.fs.Path
    attr_reader :path
    
    # Path.new("/path/on/hadoop")
    def initialize(p)
      @path=Path.new(p)
    end
    
  end
  
end