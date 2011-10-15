module Hdfs

  require "delegate"
  
  
  class File < Delegator
    
    
    
    def initialize(path,mode="r")
      raise Errno::ENOENT, "File does not exist" unless File.exists?(path)
      raise Errno::ENOENT, "File not a regular file" unless File.file?(path)
      _mode=File.parse_mode(mode)
      
      if _mode & IO::RDWR != 0
        @readable = true
        @writable = true
      elsif _mode & IO::WRONLY != 0
        @writable = true
      else # IO::RDONLY
        @readable = true
      end
      
      @stream = Hdfs.fs.open(path);
    end
    
    def __getobj__
      @stream
    end
    
    def __setobj__(obj)
      @stream = obj
    end
    
    def writable?
      @writeable
    end
    
    def self.parse_mode(mode)
      ret = 0
    
      case mode[0]
        when ?r
          ret |= IO::RDONLY
        when ?w
          ret |= IO::WRONLY | IO::CREAT | IO::TRUNC
        when ?a
          ret |= IO::WRONLY | IO::CREAT | IO::APPEND
        else
          raise ArgumentError, "invalid mode -- #{mode}"
      end
    
      return ret if mode.length == 1
    
      case mode[1]
        when ?+
          ret &= ~(IO::RDONLY | IO::WRONLY)
          ret |= IO::RDWR
        when ?b
          ret |= IO::BINARY
        when ?:
          warn("encoding options not supported in 1.8")
          return ret
        else
          raise ArgumentError, "invalid mode -- #{mode}"
      end
    
      return ret if mode.length == 2
    
      case mode[2]
        when ?+
          ret &= ~(IO::RDONLY | IO::WRONLY)
          ret |= IO::RDWR
        when ?b
          ret |= IO::BINARY
        when ?:
          warn("encoding options not supported in 1.8")
          return ret
        else
          raise ArgumentError, "invalid mode -- #{mode}"
      end
    
      ret
      
    end
    
    def self.open(*args)
      f=File.new(args[0]) if args.length == 1
      f=File.new(args[0],args[1]) if args.length == 2

      if block_given?
        begin
          yield f
        ensure
          f.close
        end
      end
      f
    end
    
    def self.exists?(path)
      Hdfs.fs.exists?(path)
    end
    
    def self.file?(path)
      Hdfs.fs.file?(path)
    end
    
  end
    
end