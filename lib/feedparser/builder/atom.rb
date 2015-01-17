# encoding: utf-8

module FeedParser

class AtomFeedBuilder

  include LogUtils::Logging


  def self.build( atom_feed )
    feed = self.new( atom_feed )
    feed.to_feed
  end

  def initialize( atom_feed )
    @feed = build_feed( atom_feed )
  end

  def to_feed
    @feed
  end



  def build_feed( atom_feed )
    feed = Feed.new
    feed.format = 'atom'

    feed.title  = handle_content( atom_feed.title, 'feed.title' )

    logger.debug "  atom | feed.id.content  >#{atom_feed.id.content}< : #{atom_feed.id.content.class.name}"

    feed.url = nil

    ## note: use links (plural to allow multiple links e.g. self,alternate,etc.)
    atom_feed.links.each_with_index do |link,i|
      logger.debug "  atom | feed.link[#{i+1}]  rel=>#{link.rel}< : #{link.rel.class.name} type=>#{link.type}< href=>#{link.href}<"

      ## for now assume alternate is link or no rel specified (assumes alternate)
      ##   note: only set if feed.url is NOT already set (via <id> for example)
      if feed.url.nil? && (link.rel == 'alternate' || link.rel.nil?)
        feed.url = link.href
      end
    end

    if feed.url.nil?
      ### todo/fix: issue warning - no link found!!!!
    end

    ## note: as fallback try id if still no url found - why?? why not??
    ##   use url only if starts_with http
    ##     might not be link e.g blogger uses for ids =>
    ##    <id>tag:blogger.com,1999:blog-4704664917418794835</id>
    ##
    ##  note: id might actually be link to feed NOT to site  (remove fallback - why - why not???)
    ##
    ## Note: remove (strip) leading and trailing spaces and newlines

    if feed.url.nil? && atom_feed.id.content.strip.start_with?( 'http' )
      feed.url = atom_feed.id.content.strip
    end


    if atom_feed.updated
      feed.updated = handle_date( atom_feed.updated, 'feed.updated' )
    end

    if atom_feed.generator
      ## Note: remove (strip) leading and trailing spaces and newlines
      feed.generator =  atom_feed.generator.content.strip
      logger.debug "  atom | feed.generator.content  >#{atom_feed.generator.content}< : #{atom_feed.generator.content.class.name}"

      # pp atom_feed.generator
      feed.generator_version = atom_feed.generator.version
      feed.generator_uri     = atom_feed.generator.uri
      logger.debug "  atom | feed.generator.version  >#{atom_feed.generator.version}< : #{atom_feed.generator.version.class.name}"
      logger.debug "  atom | feed.generator.uri      >#{atom_feed.generator.uri}< : #{atom_feed.generator.uri.class.name}"
    end

    if atom_feed.subtitle
      feed.summary =  handle_content( atom_feed.subtitle, 'feed.subtitle => summary' )
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

    item.title     = handle_content( atom_item.title, 'item.title' )

    ## Note: item might have many links
    ##   e.g. see blogger (headius)
    ##   <link rel='replies' type='application/atom+xml' href='http://blog.headius.com/feeds/3430080308857860963/comments/default' title='Post Comments'/>
    ##   <link rel='replies' type='text/html' href='http://blog.headius.com/2014/05/jrubyconfeu-2014.html#comment-form' title='0 Comments'/>
    ##   <link rel='edit' type='application/atom+xml' href='http://www.blogger.com/feeds/4704664917418794835/posts/default/3430080308857860963'/>
    ##   <link rel='self' type='application/atom+xml' href='http://www.blogger.com/feeds/4704664917418794835/posts/default/3430080308857860963'/>
    ##   <link rel='alternate' type='text/html' href='http://blog.headius.com/2014/05/jrubyconfeu-2014.html' 

    item.url = nil

    if atom_item.links.size == 1
      item.url       = atom_item.link.href
      logger.debug "  atom | item.link.href  >#{atom_item.link.href}< : #{atom_item.link.href.class.name}"
    else
      ## note: use links (plural to allow multiple links e.g. self,alternate,etc.)
      atom_item.links.each_with_index do |link,i|
        logger.debug "  atom | item.link[#{i+1}]  rel=>#{link.rel}< : #{link.rel.class.name} type=>#{link.type}< href=>#{link.href}<"
        ## for now assume alternate is link or no rel specified (assumes alternate)
        ##   note: only set if feed.url is NOT already set (via <id> for example)
        if item.url.nil? && (link.rel == 'alternate' || link.rel.nil?)
          item.url = link.href
        end
      end
    end


    if atom_item.updated
      item.updated    = handle_date( atom_item.updated, 'item.updated' )
    end

    if atom_item.published
      item.published  = handle_date( atom_item.published, 'item.published' )
    end


    item.guid       =  atom_item.id.content
    logger.debug "  atom | item.id.content  >#{atom_item.id.content}< : #{atom_item.id.content.class.name}"

    if atom_item.content
      item.content = atom_item.content.content
    end

    if atom_item.summary
      item.summary = handle_content( atom_item.summary, 'item.summary' )
    end

    item
  end # method build_feed_item



  def handle_date( el, name )
    ## change time to utc if present? why? why not?
    #  --  .utc.strftime( "%Y-%m-%d %H:%M" )

    ###############
    # examples:
    #  2015-01-02 01:56:06 +0100

    logger.debug "  atom | #{name}.content  >#{el.content}< : #{el.content.class.name}"

    # NOTE: empty updated.content possible e.g.  used by google groups feed (e.g. <updated></updated>)
    #   will return nil : NilClass

    ## convert from time to to_datetime  (avoid errors on windows w/ builtin rss lib)
    date = if el.content.nil?
             nil
           else
             el.content.to_datetime
           end

    date
  end


  def handle_content( el, name )   ## rename to handle_plain_vanilla_text_content - why? why not?
    ### todo/fix: if type html ?? strip html tags n attributes
    ##    always strip html tags n attributes?? why? why not?

    ## check if content.nil? possible e.g. <title></title> => empty string or nil?

    ## note: dump head (first 30 chars)
    logger.debug "  atom | #{name}.content[0..30] (type=>#{el.type}<)  >#{el.content[0..30]}< : #{el.content.class.name}"

    ## note: always strip leading and trailing whitespaces (spaces/tabs/newlines)
    text = el.content.strip
    text
  end


end # AtomFeedBuilder
end # FeedParser
