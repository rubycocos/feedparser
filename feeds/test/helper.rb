# encoding: utf-8


require 'logutils'
require 'textutils'

# note: for now use "packaged" version in gem
#  (not the source in ../feedparser/lib)
require 'feedparser'

# note: add microformats support (optional)
require 'microformats'



require 'minitest/autorun'


LogUtils::Logger.root.level = :debug



def walk(root, &block)
  Dir.foreach(root) do |name|
    ## puts "name: #{name}"
    path = File.join(root, name)

    if name == '.' || name == '..'
      next
    elsif File.directory?( path )

      ## note: skip .git !!
      ##        test folder with ruby test scripts
      next if ['.git', 'test'].include?( name )

      puts "** directory: #{path}/"
      walk( path, &block )
    else
      puts "  #{name}"
      block.call( path )   ## same as yield( path )
    end
  end
end


## add custom assert
module MiniTest
class Test


  ## note:
  ##   regex excape  bracket: [ to \[
  ##   \\ needs to get escaped twice e.g. (\\ becomes \)
  TXT_BEGIN  = "\\[\\["
  TXT_END    = "\\]\\]"


  def assert_feed( text, tests, opts={} )


    name =  opts[:name] || '<unknown>'


    feed = FeedParser::Parser.parse( text )

    ##################################################
    ## pass 1: remove blank lines & comment lines

    lines = []

    tests.each_line do |line|
      line = line.strip

      if line.start_with? '#'
        next     ## skip comment lines too
      end


      if line == '__END__'
        break    ## support end of file marker (skip/ignore all lines after __END__)
      end

      lines << line
    end


    #########################################
    ## pass 2: "fold" multi-line items
    ##  e.g.
    ##  feed.items[0].description: [[
    ##     In the United States, the social media giant has been an advocate of equal treatment of all Internet content.
	  ##     In India, regulators who share that belief have effectively blocked a free Facebook service.
    ##  ]]
    ##    becomes =>:
    ##  feed.items[0].description: In the United States, the social media giant has been an advocate of equal treatment of all Internet content. In India, regulators who share that belief have effectively blocked a free Facebook service.
    ##

    ##
    ##  use [[> (instead of just [[)  to mark string as to preserve newlines
    ##   or [[|  |]] (two brackets with pipe??) or [[[ ]]] (three brackets)  - why? why not?
    ##  or use python style """ and """" - why? why not?


    #######
    ##  note: preserve blank lines in multi-line "verbatim" items
    ##

    lines_ii = []
    buf = ''
    inside_txt = false

    lines.each do |line|

      if inside_txt == false

        if line =~ /#{TXT_BEGIN}/
          s = StringScanner.new( line )
          expr  = s.scan_until( /(?=#{TXT_BEGIN})/ )
          _     = s.scan( /#{TXT_BEGIN}/ )
          value = s.rest

          buf = ''   # reset
          buf << expr.strip    # add expresion before TXT_BEGIN

          if value.nil? || value.strip.empty?
            # add nothing ;-)
          else
            buf << ' '
            buf << value.strip
          end
          inside_txt = true
        else
           if line =~ /^[ \t]*$/
             next        ## skip blank lines (NOT in "verbatim" multi-line string blocks)
           end

           lines_ii << line    # copy as is 1:1
        end
      else   ## inside_txt == true
        if line =~ /#{TXT_END}/
          s = StringScanner.new( line )
          value = s.scan_until( /(?=#{TXT_END})/ )
          _     = s.scan( /#{TXT_END}/ )
          _     = s.rest

          if value.strip.empty?
             # add nothing ;-)
          else
             buf << ' '
             buf << value.strip
          end
          lines_ii << buf   ## add "folded" line
          inside_txt = false
        else
          if line.strip.empty?
            ##  empty lines get skipped for now => add support for mode with preserved newlines why? why not???
          else
            buf << " "   ## note: newline converter to just one space
            buf << line.strip
          end
        end
      end
    end  # each lines



    #########################################
    ## pass 3: eval asserts, finally ;-)

    lines_ii.each do |line|

      if line.start_with? '>>>'
        ## for debugging allow "custom" code e.g. >>> pp feed.items[0].summary etc.
        code = line[3..-1].strip
        msg  = "eval in #{name}: >>> #{code}"
      else
        pos = line.index(':')   ## assume first colon (:) is separator
        expr  = line[0...pos].strip    ## NOTE: do NOT include colon (thus, use tree dots ...)
        value = line[pos+1..-1].strip

        ##  for ruby code use |>  or >> or >>> or =>  or $ or | or RUN or  ????
        ##   otherwise assume "literal" string

        if value.start_with? '>>>'
           value = value[3..-1].strip
           msg   = "assert in #{name}: >>> #{expr}  ==  #{value}"

          if value == 'nil'
             code = "assert_nil #{expr}, %{#{msg}}"  ## note: use assert_nil for nils
          else
             code = "assert_equal #{value}, #{expr}, %{#{msg}}"
          end
        else # assume value is a "plain" string
          ## note use %{ } so value can include quotes ('') etc.
          msg  = %{assert in #{name}: #{expr}  ==  "#{value}"}
          code = "assert_equal %{#{value}}, #{expr}, %{#{msg}}"
        end
      end

      puts msg
      eval( code )
    end  # each line
  end

end
end # module MiniTest
