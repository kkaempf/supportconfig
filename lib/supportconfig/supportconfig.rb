module Supportconfig

  #
  # class Supportconfig
  #   base class
  #
  # contains generic file parser
  #

  class Supportconfig
    def initialize dir, fname
      @fname = fname
      parse File.join(dir, fname)
    end
private

    def callback section, content
      begin
        self.send section, content
#      rescue NameError
#        STDERR.puts "Section '#{section}' not implemented for #{self.class}"
      rescue ArgumentError => arg
        STDERR.puts "Bad content for '#{section}' of #{self.class}"
        raise
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
 
    def parse file
      File.open(file) do |f|
        content = []
        section = nil
        f.each do |l|
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
        self.close
      end
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
