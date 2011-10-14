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
      @fs.exists(path.path)
    end
    
    def file?(path)
      @fs.isFile(path.path)
    end
    
    def open(path)
      @fs.open(path.path).to_io
    end
  end

end