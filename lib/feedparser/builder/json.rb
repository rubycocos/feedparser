# encoding: utf-8

module FeedParser

class JsonFeedBuilder

  include LogUtils::Logging


  def self.build( hash )
    feed = self.new( hash )
    feed.to_feed
  end

  def initialize( hash )
    @feed = build_feed( hash )
  end

  def to_feed
    @feed
  end



  def build_feed( h )
    feed = Feed.new
    feed.format = 'json'

    feed.title    = h['title']
    feed.url      = h['home_page_url']
    feed.feed_url = h['feed_url']
    feed.summary  = h['description']



    items = []
    h['items'].each do |hash_item|
      items << build_feed_item( hash_item )
    end
    feed.items = items

    feed # return new feed
  end # method build_feed_from_json



  def build_feed_item( h )
    item = Item.new   # Item.new

    item.guid       = h['id']
    item.title      = h['title']
    item.url        = h['url']

    ## convert date if present (from string to date type)
    date_published_str = h['date_published']
    if date_published_str
      item.published  = DateTime.iso8601( date_published_str )
    end

    date_modified_str = h['date_modified']
    if date_modified_str
      item.updated  = DateTime.iso8601( date_modified_str )
    end


    item.content = h['content_html']

    ## todo/fix: add check for content_text too - why? why not??
    ##   use item.summary for plain text version - why? why not??

    item
  end # method build_feed_item


end # JsonFeedBuilder
end # FeedParser
