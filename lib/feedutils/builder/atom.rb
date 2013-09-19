
module FeedUtils

  def build_feed_from_atom( atom_feed )
    feed = Feed.new
    feed.object = atom_feed
    feed.title  = atom_feed.title.content
    feed.format = 'atom'

    items = []
    atom_feed.items.each do |atom_item|
      items << build_feed_item_from_atom( atom_item )
    end
    feed.items = items

    feed # return new feed
  end # method build_feed_from_atom

  def build_feed_item_from_atom( atom_item )
    item = Item.new   # Item.new
    item.object = atom_item

    item.title     = atom_item.title.content
    item.url       = atom_item.link.href

    ## todo: check if updated or published present
    #    set 
    item.updated    =  atom_item.updated.content.utc.strftime( "%Y-%m-%d %H:%M" )
    item.published  =  item.updated  # fix: check if publshed set

    item.guid       =  atom_item.id.content


    # todo: move logic to updater or something
    #  - not part of normalize

    if atom_item.summary
      item.content = atom_item.summary.content
    else
      if atom_item.content
        text  = atom_item.content.content.dup
        ## strip all html tags
        text = text.gsub( /<[^>]+>/, '' )
        text = text[ 0..400 ] # get first 400 chars
        ## todo: check for length if > 400 add ... at the end???
        item.content = text
      end
    end

    puts "- #{atom_item.title.content}"
    puts "  link >#{atom_item.link.href}<"
    puts "  id (~guid) >#{atom_item.id.content}<"

    ### todo: use/try published first? why? why not?
    puts "  updated (~pubDate) >#{atom_item.updated.content}< >#{atom_item.updated.content.utc.strftime( "%Y-%m-%d %H:%M" )}< : #{atom_item.updated.content.class.name}"
    puts

    # puts "*** dump item:"
    # pp item

    item
  end # method build_feed_item_from_atom


end # FeedUtils