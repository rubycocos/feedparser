
module FeedUtils


  class Feed
    attr_accessor :object

    attr_accessor :format   # e.g. atom|rss 2.0|etc.
    attr_accessor :title
    attr_accessor :title_type  # e.g. text|html  (optional) -use - why?? why not??

    attr_accessor :items

  end  # class Feed


  class Item
    attr_accessor :object   # orginal object (e.g RSS item or ATOM entry etc.)

    attr_accessor :title
    attr_accessor :title_type    # optional for now (text|html) - not yet set
    attr_accessor :url      # todo: rename to link (use alias) ??
    attr_accessor :content
    attr_accessor :content_type  # optional for now (text|html) - not yet set

## todo: add summary (alias description)  ???
## todo: add author/authors
## todo: add category/categories

    attr_accessor :updated
    attr_accessor :published

    attr_accessor :guid     # todo: rename to id (use alias) ??
  end  # class Item


  class Parser

    ### Note: lets keep/use same API as RSS::Parser for now
    def initialize( xml )
      @xml = xml
    end
    
    def parse
      parser = RSS::Parser.new( @xml )
      parser.do_validate            = false
      parser.ignore_unknown_element = true

      puts "Parsing feed..."
      feed_wild = parser.parse  # not yet normalized

      puts "  feed.class=#{feed_wild.class.name}"

      if feed_wild.is_a?( RSS::Atom::Feed )
        feed = AtomFeedBuilder.build( feed_wild )
      else  # -- assume RSS::Rss::Feed
        feed = RssFeedBuilder.build( feed_wild )
      end

      puts "== #{feed.format} / #{feed.title} =="
      feed # return new (normalized) feed
    end
 
  end  # class Parser


end # module FeedUtils
