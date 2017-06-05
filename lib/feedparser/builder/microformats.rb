# encoding: utf-8

module FeedParser


class HyFeedBuilder

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

    b = HyBuilder.new( h )     ## convert hash to structs

    ##  use first feed - more really possible?
    ##   fix/todo: handle no feed too!!!
    hy = b.feeds[0]

    ## pp hy

    feed = Feed.new
    feed.format = 'html'

    ### todo: add
    ## - feed.title
    ## - feed.url
    ## - feed.feed_url
    ## - feed.summary
    ## - feed.authors
    ## etc.

    hy.entries.each do |entry|
      feed.items << build_item( entry )
    end

    feed # return new feed
  end # method build_feed


  def build_author( hy )
    author = Author.new

    author.name     = hy.name

    ## todo - add:
    ## author.url

    author
  end



  def build_item( hy )
    item = Item.new   # Item.new

    item.title           = hy.name
    item.url             = hy.url
    item.published_local = hy.published_local
    item.published       = hy.published

    item.content_html    = hy.content_html
    item.content_text    = hy.content_text
    item.summary         = hy.summary

    ##  check: how to add an id - auto-generate - why? why not??
    ## item.id         = h['id']

    hy.authors.each do |author|
      item.authors << build_author( author )
    end

    item
  end # method build_item

end # class HyFeedBuilder



class HyFeed
  attr_accessor :entries

  def initialize
     @entries = []
  end
end # class HyFeed


class HyEntry
   attr_accessor :name
   attr_accessor :content
   attr_accessor :content_text
   attr_accessor :summary

   attr_accessor :published          # utc time
   attr_accessor :published_local    # local time (with timezone/offset)
   attr_accessor :url

   attr_accessor :authors      # note: allow multiple authors

   # note: title is an alias for name
   alias :title  :name
   alias :title= :name=

   # note: content_html is an alias for name
   alias :content_html  :content
   alias :content_html= :content=

   def initialize
     @authors = []
   end

end  ## class HyEntry


class HyAuthor
   attr_accessor :name
   attr_accessor :url
end  ## class HyAuthor




class HyBuilder

   attr_reader :feeds

   def initialize( hash )
     @h     = hash
     @feeds = []
     build

     pp @feeds
   end

   def build

    entries = []
    @h['items'].each_with_index do |item_hash,i|
      puts "item #{i+1}:"
      pp item_hash

      types = item_hash['type']
      pp types
      if types.include?( 'h-feed' )
        @feeds << build_feed( item_hash )
      elsif types.include?( 'h-entry' )
        entries << build_entry( item_hash )
      else
        ## unknown type; skip for now
      end
    end

    ## wrap all "loose" entries in a "dummy" h-entry feed
    if entries.any?
       feed = HyFeed.new
       feed.entries = entries
       @feeds << feed
    end

  end # method build

  def build_feed( h )
     puts "  build_feed"

     feed = HyFeed.new

     h['children'].each_with_index do |item_hash,i|
      puts "item #{i+1}:"
      pp item_hash

      types = item_hash['type']
      pp types
      if types.include?( 'h-entry' )
        feed.entries << build_entry( item_hash )
      else
        ## unknown type; skip for now
      end
     end

     feed
  end  ## method build_feed


  def build_entry( h )
     puts "  build_entry"

     entry = HyEntry.new

     props = h['properties']
     pp props

     entry.name    = props['name'].join( '  ')     # check an example with more entries (how to join??)

     if props['summary']
       entry.summary = props['summary'].join( '  ' )
     end

     if props['content']
       ## add up all value attribs in content
       entry.content_text =  props['content'].map { |h| h[:value] }.join( '  ' ).strip
       ## add up all html attribs in content; plus strip leading n trailing whitespaces
       entry.content =  props['content'].map { |h| h[:html] }.join( '  ' ).strip
     end


     # get first field in array  -- check if really ever possible more than one? what does it mean (many dates)???
     ##  todo: check if datetime is always utc (or local possible?)
     url_str = props.fetch( 'url', [] )[0]
     if url_str
       entry.url = url_str
     end

     # get first field in array  -- check if really ever possible more than one? what does it mean (many dates)???
     ##  todo: check if datetime is always utc (or local possible?)
     published_str = props.fetch( 'published', [] )[0]
     pp published_str
     if published_str
       ## entry.published = DateTime.iso8601( published_str )
       entry.published_local = DateTime.parse( published_str )
       entry.published       = entry.published_local.utc
     end

     ## check for authors
     if props['author']
       props['author'].each do |author_hash|
         pp author_hash
         entry.authors << build_author( author_hash )
       end
     end

     entry
  end  # method build_entry

  def build_author( h )
    puts "  build_author"

    author = HyAuthor.new

    author.name = h['value']

    ## todo/fix: -- note: for now skip possible embedded h-card
    author
  end  # method build_author


end  # class HyBuilder



end # module FeedParser
