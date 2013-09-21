
module FeedUtils

### todo/fix:
#    rename to Rss20FeedBuilder?? or FeedBuilderRss20 ??

class RssFeedBuilder

  include LogUtils::Logging

  def initialize( rss_feed )
    @feed = build_feed( rss_feed )
  end

  def to_feed
    @feed
  end

  def self.build( rss_feed )
    feed = self.new( rss_feed )
    feed.to_feed
  end


  def build_feed( rss_feed )
    feed = Feed.new
    feed.object = rss_feed
    feed.format = "rss #{rss_feed.rss_version}"

    feed.title     = rss_feed.channel.title           # required
    feed.url       = rss_feed.channel.link            # required
    feed.summary   = rss_feed.channel.description     # required

     # NOTE:
     # All date-times in RSS conform
     #   to the Date and Time Specification of RFC 822
     #  e.g. Sun, 19 May 2012 15:21:36 GMT  or
     #       Sat, 07 Sep 2013 00:00:01 GMT

    feed.built     = rss_feed.channel.lastBuildDate   # optional
    feed.published = rss_feed.channel.pubDate         # optional

    logger.debug "  rss | channel.lastBuildDate: >#{rss_feed.channel.lastBuildDate}< : #{rss_feed.channel.lastBuildDate.class.name}"
    logger.debug "  rss | channel.pubDate: >#{rss_feed.channel.pubDate}< : #{rss_feed.channel.pubDate.class.name}"


    feed.generator = rss_feed.channel.generator       # optional

    logger.debug "  rss | channel.generator: >#{rss_feed.channel.generator}< : #{rss_feed.channel.generator.class.name}"


    items = []
    rss_feed.items.each do |rss_item|
      items << build_feed_item( rss_item )
    end
    feed.items = items

    feed # return new feed
  end

  def build_feed_item( rss_item )

    item = Item.new
    item.object = rss_item

    item.title     = rss_item.title
    item.url       = rss_item.link

## todo:
##  check if feedburner:origLink present - if yes, use it for url/link
##  example: use
##  - <feedburner:origLink>http://www.rubyflow.com/items/9803-gotta-ruby-s-syntax</feedburner:origLink></item>
##   instead of
##  - <link>http://feedproxy.google.com/~r/Rubyflow/~3/Ym9Sltg_2_c/9803-gotta-ruby-s-syntax</link>


    item.summary   = rss_item.description

    logger.debug "  rss | item.title: >#{rss_item.title}< : #{rss_item.title.class.name}"
    logger.debug "  rss | item.link: >#{rss_item.link}< : #{rss_item.link.class.name}"

    # NOTE:
    # All date-times in RSS conform
    #   to the Date and Time Specification of RFC 822
    #  e.g. Sun, 19 May 2012 15:21:36 GMT  or
    #       Sat, 07 Sep 2013 00:00:01 GMT

    item.published = rss_item.pubDate     # .utc.strftime( "%Y-%m-%d %H:%M" )

    logger.debug "  rss | item.pubDate: >#{rss_item.pubDate}< : #{rss_item.pubDate.class.name}"
 
    ## fix/todo: add
    ## check for <content:encoded>
    ##   full content  (example use e.g. in sitepoint/ruby/feed/)
    # content:  item.content_encoded,
  
    # if item.content_encoded.nil?
    # puts " using description for content"
    # end

    ## fix/todo: check if rss_item.guid present? !!!!
    item.guid     = rss_item.guid.content
        
    logger.debug "  rss | item.guid.content: >#{rss_item.guid.content}< : #{rss_item.guid.content.class.name}"

    ### todo: add support or authors (incl. dc:creator)
    ##  <dc:creator>Dhaivat Pandya</dc:creator>

    #  todo: categories
    # <category><![CDATA[Gems]]></category>
    # <category><![CDATA[Ruby]]></category>
    # <category><![CDATA[Ruby on Rails]]></category>


    item
  end # method build_feed_item_from_rss

end # class RssFeedBuilder
end # module FeedUtils
