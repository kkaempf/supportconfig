module Supportconfig

  #
  # class Supportconfig
  #   base class
  #
  # contains generic file parser
  #

  class Supportconfig
    #
    # Constructor
    #
    # @param
    #  handle [String|Enumerable] director name or TarReader
    #  fname  [String] file to read (from directory or tarball)
    #
    def initialize handle, fname
      @fname = fname
      if handle.is_a? Enumerable
        # assume TarReader
        r = Regexp.new(fname)
        handle.each do |f|
          next unless f.full_name =~ r
          puts "Found #{f.full_name}"
          parse f
          break
        end
      else
        # assume directory
        File.open(File.join(handle, fname)) do |f|
          parse f
        end
      end
    end
private

    def callback section, content
      sym = section.to_sym
      if self.respond_to? sym
        self.send sym, content
      end
    end
    #
    # generic parser for supportconfig .txt files
    #
    # .txt files have multiple section, every section
    # is named and starting with
    #   #==[ <name> ]====...
    # following is content until EOF or the next section
    #
    # this parser splits files into sections and assembles
    # the section content as array of lines
    #
    # the section name is used as a callback name
 
    def parse io
      content = []
      section = nil
      unless io.respond_to? :each
        io = io.read.split("\n")
      end
      io.each do |l|
        l.chomp!
        next if l.empty?
        if l =~ /#==\[ (.*) \]===/
          # new section start
          if section
            # old section present
            callback section, content
            section = nil
            content = []
          end
          section = $1.downcase.tr(" ", "_")
        elsif section
          content << l
        else
          # skip header
        end
      end
      # send final section
      callback section, content if section
    end
public 
    #
    #  Example callback
    #
    #
    # section:
    # #==[ Command ]======================================#
    #
    def command content
      # empty - derive from Supportconfig and implement there
    end

    #
    # close file (eof reached)
    #
    def close
      STDERR.puts "#{self.class}.close not implemented !"
    end

  end # class

end # module
