module Hdfs
  private
  
  class FileSystem
    import org.apache.hadoop.conf.Configuration
    import org.apache.hadoop.fs.FileSystem
    
    attr_reader :fs
    
    def initialize
      conf = Configuration.new
      @fs=org.apache.hadoop.fs.FileSystem.get(conf)
      puts "HDFS has been created"
    end
    
    def exists?(path)
      path = coerce_path path
      @fs.exists(path.path)
    end
    
    def file?(path)
      path = coerce_path path
      @fs.isFile(path.path)
    end
    
    def open(path)
      path = coerce_path path
      @fs.open(path.path).to_io
    end
    
    def directory?(path)
      path = coerce_path path
      @fs.getFileStatus(path.path).isDir
    end
    
    private
    def coerce_path(path)
      Path.new(path) unless path.is_a? Path
    end
  end

end