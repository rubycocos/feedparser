
module FeedParser

### todo/fix:
#    rename to Rss20FeedBuilder?? or FeedBuilderRss20 ??

class RssFeedBuilder

  include LogUtils::Logging


  def self.build( rss_feed )
    feed = self.new( rss_feed )
    feed.to_feed
  end

  def initialize( rss_feed )
    @feed = build_feed( rss_feed )
  end

  def to_feed
    @feed
  end



  def build_feed( rss_feed )
    feed = Feed.new
    feed.format = "rss #{rss_feed.rss_version}"

    logger.debug "  rss | feed.version  >#{rss_feed.rss_version}<"

    feed.title     = handle_content( rss_feed.channel.title,       'feed.title'       )  # required
    feed.summary   = handle_content( rss_feed.channel.description, 'feed.description => summary' )  # required
    feed.url       = rss_feed.channel.link            # required

    feed.updated   = handle_date( rss_feed.channel.lastBuildDate, 'feed.lastBuildDate => updated' )  # optional
    feed.published = handle_date( rss_feed.channel.pubDate,       'feed.pubDate => published'     )  # optional


    feed.generator = rss_feed.channel.generator    # optional

    logger.debug "  rss | feed.generator  >#{rss_feed.channel.generator}< : #{rss_feed.channel.generator.class.name}"


    items = []
    rss_feed.items.each do |rss_item|
      items << build_feed_item( rss_item )
    end
    feed.items = items

    feed # return new feed
  end

  def build_feed_item( rss_item )

    item = Item.new

    item.title     = handle_content( rss_item.title, 'item.title' )
    item.url       = rss_item.link

    logger.debug "  rss | item.link  >#{rss_item.link}< : #{rss_item.link.class.name}"


## todo:
##  check if feedburner:origLink present - if yes, use it for url/link
##  example: use
##  - <feedburner:origLink>http://www.rubyflow.com/items/9803-gotta-ruby-s-syntax</feedburner:origLink></item>
##   instead of
##  - <link>http://feedproxy.google.com/~r/Rubyflow/~3/Ym9Sltg_2_c/9803-gotta-ruby-s-syntax</link>


    item.summary   = handle_content( rss_item.description, 'item.description => summary' )

    # check for <content:encoded>
    # -- using RSS 1.0 content module in RSS 2.0
    item.content = rss_item.content_encoded
    logger.debug "  rss | item.content_encoded[0..40]  >#{rss_item.content_encoded ? rss_item.content_encoded[0..40] : ''}< : #{rss_item.content_encoded.class.name}"


    item.updated   = handle_date( rss_item.pubDate, 'item.pubDate => updated' )


    ## fix/todo: check if rss_item.guid present? !!!!
    ##
    ##  might be the case e.g. check lambda-the-ultimate.org, for example

    if rss_item.guid && rss_item.guid.content
      item.guid     = rss_item.guid.content
      logger.debug "  rss | item.guid.content  >#{rss_item.guid.content}< : #{rss_item.guid.content.class.name}"
    else
      item.guid     = rss_item.link
      logger.warn "  rss | item.guid.content missing !!!! - using link for guid"
    end

    ### todo: add support or authors (incl. dc:creator)
    ##  <dc:creator>Dhaivat Pandya</dc:creator>

    #  todo: categories
    # <category><![CDATA[Gems]]></category>
    # <category><![CDATA[Ruby]]></category>
    # <category><![CDATA[Ruby on Rails]]></category>

    item
  end # method build_feed_item_from_rss



  def handle_date( el, name )
    ## change time to utc if present? why? why not?
    #  --  .utc.strftime( "%Y-%m-%d %H:%M" )

    # NOTE:
    # All date-times in RSS conform
    #   to the Date and Time Specification of RFC 822
    #  e.g. Sun, 19 May 2012 15:21:36 GMT  or
    #       Sat, 07 Sep 2013 00:00:01 GMT

    ## convert from time to to_datetime  (avoid errors on windows w/ builtin rss lib)

    logger.debug "  rss | #{name}  >#{el}< : #{el.class.name}"


    ## convert from time to to_datetime  (avoid errors on windows w/ builtin rss lib)
    date = if el.nil?
             nil
           else
             el.to_datetime
           end

    date
  end

  def handle_content( el, name )
    ## note:
    #   use for feed.title, feed.description
    #           item.title, item.description
    #
    # do NOT use for others e.g. feed.generator, etc.


    ## todo/fix: strip html tags n attributes ???

    logger.debug "  rss | #{name}  >#{el}< : #{el.class.name}"

    text = if el.nil?
             nil
           else
             el.strip
           end
    text
  end


end # class RssFeedBuilder
end # module FeedParser
