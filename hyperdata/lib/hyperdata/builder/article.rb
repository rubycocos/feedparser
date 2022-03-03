# encoding: utf-8

module Hyperdata

class ArticleFeedBuilder

  include LogUtils::Logging


  def self.build( doc )
    feed = self.new( doc )
    feed.to_feed
  end

  def initialize( doc )
    @feed = build_feed( doc )
  end

  def to_feed() @feed; end




  def build_feed( doc )
    feed = Feed.new

    ## todo: find title from page_url

    articles = doc.css( 'article' )
    pp articles.size
    pp articles

    articles.each do |article|
      feed.items << build_item( article )
    end

    feed # return new feed
  end # method build_feed




  def build_item( ht )
    item = Item.new   # Item.new

    ## check for h1

    headings = ht.css( 'h1' )
    if headings.any?
      item.title = headings[0].text
    end

    paras = ht.css( 'p' )
    if paras[1]   ## quick hack: for now assume 2nd para is summary if present
      item.summary = paras[1].text
    end

    item
  end # method build_item

end # ArticleFeedBuilder
end # Hyperdata
