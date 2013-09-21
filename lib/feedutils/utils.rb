
module FeedUtils


  class Feed
    attr_accessor :object

    attr_accessor :format   # e.g. atom|rss 2.0|etc.
    attr_accessor :title
    attr_accessor :title_type  # e.g. text|html|html-escaped  (optional) -use - why?? why not??
    attr_accessor :url

    attr_accessor :items

    attr_accessor :summary        # e.g. description (rss)
    attr_accessor :summary_type   # e.g. text|html|html-escaped
    attr_accessor :title2         # e.g. subtitle (atom)
    attr_accessor :title2_type    # e.g. text|html|html-escaped

    attr_accessor :published
    attr_accessor :updated
    attr_accessor :built
    
    attr_accessor :generator


    def title2?
      @title2.nil? == false
    end

    def summary?
      @summary.nil? == false
    end

    def built?
      @built.nil? == false
    end
    
    def updated?
      @updated.nil? == false
    end
    
    def published?
      @published.nil? == false
    end


    def summary
      # no summary? try/return title2
      if summary?
        @summary
      else
        @title2
      end
    end

    def published
      # no published date? try/return updated or built
      if published?
        @published
      elsif updated?
        @updated
      else
        @built
      end
    end

    ## fix:
    #  add pretty printer/inspect (exclude object)

  end  # class Feed


  class Item
    attr_accessor :object   # orginal object (e.g RSS item or ATOM entry etc.)

    attr_accessor :title
    attr_accessor :title_type    # optional for now (text|html|html-escaped) - not yet set
    attr_accessor :url      # todo: rename to link (use alias) ??
    attr_accessor :content
    attr_accessor :content_type  # optional for now (text|html|html-escaped|binary-base64) - not yet set
    attr_accessor :summary
    attr_accessor :summary_type  # optional for now (text|html|html-escaped) - not yet set

## todo: add summary (alias description)  ???
## todo: add author/authors
## todo: add category/categories

    attr_accessor :published
    attr_accessor :updated

    attr_accessor :guid     # todo: rename to id (use alias) ??


    def summary?
      @summary.nil? == false
    end

    def content?
      @content.nil? == false
    end
    
    def published?
      @published.nil? == false
    end

    def updated?
      @updated.nil? == false
    end
    
    def content
      # no content? try/return summary
      if content?
        @content
      else
        @summary
      end
    end

    def published
      # no published date? try/return updated
      if published?
        @published
      else
        @updated
      end
    end


  end  # class Item


  class Parser

    include LogUtils::Logging

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

      logger.debug "  feed.class=#{feed_wild.class.name}"

      if feed_wild.is_a?( RSS::Atom::Feed )
        feed = AtomFeedBuilder.build( feed_wild )
      else  # -- assume RSS::Rss::Feed
        feed = RssFeedBuilder.build( feed_wild )
      end

      puts "== #{feed.format} / #{feed.title} =="
      feed # return new (normalized) feed
    end
    
    ### convenience class/factory method
    def self.parse( xml, opts={} )
      self.new( xml ).parse
    end

  end  # class Parser


end # module FeedUtils
