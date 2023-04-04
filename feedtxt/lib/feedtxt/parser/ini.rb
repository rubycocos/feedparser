# encoding: utf-8

module Feedtxt


class IniParser

  include LogUtils::Logging


  ### convenience class/factory method
  def self.parse( text, opts={} )
    self.new( text ).parse
  end

  ### Note: lets keep/use same API as RSS::Parser for now
  def initialize( text )
    @text = text
  end



  ## note:
  ##   regex excape  bracket: [ to \[
  ##   \\ needs to get escaped twice e.g. (\\ becomes \)
  ##  e.g. [>>>  or [>>>>>
  FEED_BEGIN = "^[ ]*\\[>>>+[ ]*$"    ## note: allow leading n trailing spaces; allow 3 or more brackets
  ##  e.g. <<<] or <<<<<<]
  FEED_END   = "^[ ]*<<<+\\][ ]*$"    ## note: allow leading n trailing spaces; allow 3 or more brackets

  ## e.g.</>  or <<</>>>
  FEED_NEXT  = "^[ ]*<+/>+[ ]*$"       ## pass 1: split/break up blocks
  ## e.g. --- or -----
  FEED_META  = "^[ ]*---+[ ]*$"       ## pass 2: break up item into metadata and content block



  def parse

    ## find start marker e.g. [>>>
    ##    use regex - allow three or more >>>>>> or <<<<<<
    ##    allow spaces before and after

    s = StringScanner.new( @text )

    prolog = s.scan_until( /(?=#{FEED_BEGIN})/ )
    ## pp prolog

    feed_begin = s.scan( /#{FEED_BEGIN}/ )
    if feed_begin.empty?    ## use blank? why? why not??
      ## nothing found return empty array for now; return nil - why? why not?
      puts "warn !!! no begin marker found e.g. |>>>"
      return []
    end


    buf =  s.scan_until( /(?=#{FEED_END})/ )
    buf = buf.strip    # remove leading and trailing whitespace

    feed_end = s.scan( /#{FEED_END}/ )
    if feed_end.empty?   ## use blank? why? why not??
      ## nothing found return empty array for now; return nil - why? why not?
      puts "warn !!! no end marker found e.g. <<<|"
      return []
    end


    ####
    ## pass 1: split blocks by </>
    ###    note: allows   <<<</>>>>

    blocks = buf.split( /#{FEED_NEXT}/ )
    ## pp blocks

    ## 1st block is feed meta data
    block1st = blocks.shift       ## get/remove 1st block from blocks
    block1st = block1st.strip     ## strip leading and trailing whitespace
    feed_metadata = ::INI.load( block1st )

    feed_items = []
    blocks.each do |block|
      ###   note: do NOT use split e.g.--- is used by markdown
      ##      only search for first --- to split (all others get ignored)
      ##    todo: make three dashes --- (3) not hard-coded (allow more)

      s2 = StringScanner.new( block )

      item_metadata = s2.scan_until( /(?=#{FEED_META})/ )
      item_metadata = item_metadata.strip    # remove leading and trailing whitespace
      item_metadata = ::INI.load( item_metadata )   ## convert to hash with inifile parser

      feed_meta = s2.scan( /#{FEED_META}/ )

      item_content = s2.rest
      item_content = item_content.strip     # remove leading and trailing whitespace

      feed_items << [item_metadata, item_content]
    end

    [ feed_metadata, feed_items ]
  end # method parse


end  # class IniParser


end # module Feedtxt
