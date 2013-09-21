
module FeedUtils

class AtomFeedBuilder

  include LogUtils::Logging

  def initialize( atom_feed )
    @feed = build_feed( atom_feed )
  end

  def to_feed
    @feed
  end

  def self.build( atom_feed )
    feed = self.new( atom_feed )
    feed.to_feed
  end


  def build_feed( atom_feed )
    feed = Feed.new
    feed.object = atom_feed
    feed.format = 'atom'

    feed.title  = atom_feed.title.content

    if atom_feed.updated
      # NOTE: empty updated.content e.g.  used by google groups feed
      #   will return nil : NilClass
      feed.updated =  atom_feed.updated.content  #  .utc.strftime( "%Y-%m-%d %H:%M" )
      logger.debug "  atom | updated.content  >#{atom_feed.updated.content}< : #{atom_feed.updated.content.class.name}"
    end

    if atom_feed.generator
      feed.generator =  atom_feed.generator.content
      logger.debug "  atom | generator.content  >#{atom_feed.generator.content}< : #{atom_feed.generator.content.class.name}"
    end

    if atom_feed.subtitle
      feed.title2 =  atom_feed.subtitle.content
      logger.debug "  atom | subtitle.content  >#{atom_feed.subtitle.content}< : #{atom_feed.subtitle.content.class.name}"
    end


    items = []
    atom_feed.items.each do |atom_item|
      items << build_feed_item( atom_item )
    end
    feed.items = items

    feed # return new feed
  end # method build_feed_from_atom

  def build_feed_item( atom_item )
    item = Item.new   # Item.new
    item.object = atom_item

    item.title     = atom_item.title.content
    item.url       = atom_item.link.href

    logger.debug "  atom | item.title.content: >#{atom_item.title.content}< : #{atom_item.title.content.class.name}"
    logger.debug "  atom | item.link.href: >#{atom_item.link.href}< : #{atom_item.link.href.class.name}"


    if atom_item.updated
      item.updated    =  atom_item.updated.content  #  .utc.strftime( "%Y-%m-%d %H:%M" )

      ## change time to utc if present? why? why not?

      logger.debug "  atom | item.updated.content  >#{atom_item.updated.content}< : #{atom_item.updated.content.class.name}"
    end
    
    if atom_item.published
      item.published   =  atom_item.published.content  #  .utc.strftime( "%Y-%m-%d %H:%M" )
      logger.debug "  atom | item.published.content  >#{atom_item.published.content}< : #{atom_item.published.content.class.name}"
    end

    # - todo/check: does it exist in atom format?
    # item.published  =  item.updated  # fix: check if publshed set

    item.guid       =  atom_item.id.content

    logger.debug "  atom | item.id.content: >#{atom_item.id.content}< : #{atom_item.id.content.class.name}"

    # todo: move logic to updater or something
    #  - not part of normalize


    ## fix/todo:
    #  also save/include full content in content

    if atom_item.content
      item.content = atom_item.content.content
    end

    if atom_item.summary
      item.summary = atom_item.summary.content
    else
      if atom_item.content
        text  = atom_item.content.content
        ## strip all html tags
        text = text.gsub( /<[^>]+>/, '' )
        text = text[ 0..400 ] # get first 400 chars
        ## todo: check for length if > 400 add ... at the end???
        item.summary = text
      end
    end

    item
  end # method build_feed_item

end # AtomFeedBuilder
end # FeedUtils