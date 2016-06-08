module Supportconfig

  #
  # class Supportconfig
  #   base class
  #
  # contains generic file parser
  #

  class Supportconfig
    def initialize client, dir, fname
      @client = client
      @fname = fname
      parse File.join(dir, fname)
    end
private
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
              self.send section, content
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
        self.send section, content if section
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
