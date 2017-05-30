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


    if h['author']
      feed.authors << build_author( h['author'] )
    end


    items = []
    h['items'].each do |hash_item|
      items << build_item( hash_item )
    end
    feed.items = items

    feed # return new feed
  end # method build_feed_from_json


  def build_author( h )
    author = Author.new

    author.name     = h['name']
    author.email    = h['email']
    author.url      = h['url']
    author.avatar   = h['avatar']

    author
  end



  def build_item( h )
    item = Item.new   # Item.new

    item.guid       = h['id']
    item.title      = h['title']
    item.url        = h['url']

    ## convert date if present (from string to date type)
    date_published_str = h['date_published']
    if date_published_str
      item.published_local  = DateTime.iso8601( date_published_str )
      item.published        = item.published_local.utc
    end

    date_modified_str = h['date_modified']
    if date_modified_str
      item.updated_local  = DateTime.iso8601( date_modified_str )
      item.updated        = item.updated_local.utc
    end


    item.content_html = h['content_html']
    item.content_text = h['content_text']
    item.summary      = h['summary']

    if h['author']
      item.authors << build_author( h['author'] )
    end

    item
  end # method build_item


end # JsonFeedBuilder
end # FeedParser
