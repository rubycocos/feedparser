
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
    feed.title  = atom_feed.title.content
    feed.format = 'atom'

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


    ## todo: check if updated or published present
    #    set 
    item.updated    =  atom_item.updated.content  #  .utc.strftime( "%Y-%m-%d %H:%M" )


    ## change time to utc if present? why? why not?

    ### todo: use/try published first? why? why not?
    logger.debug "  atom | item.updated  >#{atom_item.updated.content}< : #{atom_item.updated.content.class.name}"

    # - todo/check: does it exist in atom format?
    # item.published  =  item.updated  # fix: check if publshed set

    item.guid       =  atom_item.id.content

    logger.debug "  atom | item.id.content: >#{atom_item.id.content}< : #{atom_item.id.content.class.name}"

    # todo: move logic to updater or something
    #  - not part of normalize


    ## fix/todo:
    #  also save/include full content in content

    if atom_item.summary
      item.summary = atom_item.summary.content
    else
      if atom_item.content
        text  = atom_item.content.content.dup
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