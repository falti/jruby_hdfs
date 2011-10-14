module Hdfs

  require "delegate"
  
  class File < Delegator

    def initialize(path)
      _path=Path.new(path)
      _fs=Hdfs::fs
      raise Errno::ENOENT, "File does not exist" unless _fs.exists?(_path)
      raise Errno::ENOENT, "File not a regular file" unless _fs.file?(_path)
      
      @stream = Hdfs::fs.open(_path);
    end
    
    def __getobj__
      @stream
    end
    
    def __setobj__(obj)
      @stream = obj
    end
    
    
  end
  
  
end