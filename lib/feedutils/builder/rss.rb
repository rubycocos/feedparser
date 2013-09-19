
module FeedUtils

class RssFeedBuilder

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
    feed.title  = rss_feed.channel.title
    feed.format = "rss #{rss_feed.rss_version}"

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
      
    ## todo: check if updated or published present
    #    set 
    item.published = rss_item.pubDate.utc.strftime( "%Y-%m-%d %H:%M" )
    item.updated   = item.published
      
    # content:  item.content_encoded,
  
    # if item.content_encoded.nil?
    # puts " using description for content"
       
    item.content  = rss_item.description
    # end
        
    item.guid     = rss_item.guid.content
        
    puts "- #{rss_item.title}"
    puts "  link (#{rss_item.link})"
    puts "  guid (#{rss_item.guid.content})"
    puts "  pubDate >#{rss_item.pubDate}< >#{rss_item.pubDate.utc.strftime( "%Y-%m-%d %H:%M" )}< : #{rss_item.pubDate.class.name}"
    puts

    # puts "*** dump item:"
    # pp item

    item
  end # method build_feed_item_from_rss

end # class RssFeedBuilder
end # module FeedUtils
