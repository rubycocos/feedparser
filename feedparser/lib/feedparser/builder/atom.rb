# encoding: utf-8

module FeedParser

class AtomFeedBuilder

  include LogUtils::Logging


  def self.build( atom_feed, raw )
    feed = self.new( atom_feed, raw )
    feed.to_feed
  end

  def initialize( atom_feed, raw )
    @feed = build_feed( atom_feed, raw )
  end

  def to_feed
    @feed
  end



  def build_feed( atom_feed, raw )    ## fix/todo: rename atom_feed to atom or wire or xml or in ???
    feed = Feed.new
    feed.format = 'atom'

    feed.title  = handle_content( atom_feed.title, 'feed.title' )

    logger.debug "  atom | feed.id.content  >#{atom_feed.id.content}< : #{atom_feed.id.content.class.name}"


    ## try to find self link if present
    ## note: use links (plural to allow multiple links e.g. self,alternate,etc.)
    atom_feed.links.each_with_index do |link,i|
      logger.debug "  atom | feed.link[#{i+1}]  rel=>#{link.rel}< : #{link.rel.class.name} type=>#{link.type}< href=>#{link.href}<"

      if feed.feed_url.nil? && link.rel == 'self'
        feed.feed_url = link.href
      end
    end


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


    if atom_feed.updated && atom_feed.updated.content    ## note: content might be nil if <updated></updated> empty
      feed.updated_local = handle_date( atom_feed.updated, 'feed.updated' )
      feed.updated       = feed.updated_local.utc
    end

    if atom_feed.generator
      ## Note: remove (strip) leading and trailing spaces and newlines
      feed.generator.name =  atom_feed.generator.content.strip
      logger.debug "  atom | feed.generator.content  >#{atom_feed.generator.content}< : #{atom_feed.generator.content.class.name}"

      # pp atom_feed.generator
      feed.generator.version = atom_feed.generator.version
      feed.generator.url     = atom_feed.generator.uri
      logger.debug "  atom | feed.generator.version  >#{atom_feed.generator.version}< : #{atom_feed.generator.version.class.name}"
      logger.debug "  atom | feed.generator.uri      >#{atom_feed.generator.uri}< : #{atom_feed.generator.uri.class.name}"
    end

    if atom_feed.subtitle
      feed.summary =  handle_content( atom_feed.subtitle, 'feed.subtitle => summary' )
    end


    ## check for authors
    atom_feed.authors.each do |atom_author|
      feed.authors << build_author( atom_author )
    end

    ## check for categories/tags
    atom_feed.categories.each do |atom_cat|
      feed.tags << build_tag( atom_cat )
    end


    atom_feed.items.each do |atom_item|
      feed.items << build_item( atom_item )
    end


    if defined?( Oga )
      # Use Oga as generic xml parser to access elements not adressed by the core RSS module like media:
      parsed_xml = Oga.parse_xml( raw )
      xml_items = parsed_xml.xpath( '/feed/entry' )
      xml_items.each_with_index do |xml_item, i|
          feed.items[i] = add_meta_items( feed.items[i], xml_item )
      end
    end

    feed # return new feed
  end # method build_feed_from_atom


  def build_author( atom_author )
    ## pp atom_author
    author = Author.new

    ## note: always strip leading n trailing spaces (from content)
    author.name  = atom_author.name.content.strip    if atom_author.name
    author.url   = atom_author.uri.content.strip     if atom_author.uri
    author.email = atom_author.email.content.strip   if atom_author.email

    author
  end  # build_author


  def build_tag( atom_cat )
    ## pp atom_cat
    tag = Tag.new

    ## note: always strip leading n trailing spaces
    ##         and add if preset (not blank/empty e.g. not nil or "")
    tag.name     = atom_cat.term.strip    if atom_cat.term   && !atom_cat.term.empty?
    tag.scheme   = atom_cat.scheme.strip  if atom_cat.scheme && !atom_cat.scheme.empty?

    tag
  end  # build_tag


  def build_item( atom_item )
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


    if atom_item.updated && atom_item.updated.content
      item.updated_local  = handle_date( atom_item.updated, 'item.updated' )
      item.updated        = item.updated_local.utc
    end

    if atom_item.published && atom_item.published.content
      item.published_local  = handle_date( atom_item.published, 'item.published' )
      item.published        = item.published_local.utc
    end


    item.guid       =  atom_item.id.content
    logger.debug "  atom | item.id.content  >#{atom_item.id.content}< : #{atom_item.id.content.class.name}"

    if atom_item.content
      item.content = atom_item.content.content
    end

    if atom_item.summary
      item.summary = handle_content( atom_item.summary, 'item.summary' )
    end

    ## check for authors
    atom_item.authors.each do |atom_author|
      item.authors << build_author( atom_author )
    end

    ## check for categories/tags
    atom_item.categories.each do |atom_cat|
      item.tags << build_tag( atom_cat )
    end


    ## check for attachments / media enclosures
    ###  todo/fix: allow more than one attachment/enclosure
    if atom_item.links
      enclosure = atom_item.links.detect{ |x| x.rel == 'enclosure' }
      if enclosure
        attachment = Attachment.new
        attachment.url    = enclosure.href
        attachment.length = enclosure.length
        attachment.type   = enclosure.type
        item.attachments << attachment
      end
    end

    item
  end # method build_item


  # Add additional elements, currently the media: namespace elements
  # Note: This tries to accomodate both the different ways to transport the data via the spec https://www.rssboard.org/media-rss/ and the practice by Youtube of grouping everything under media:group
  def add_meta_items( feed_item, xml_item )
    if xml_item.at_xpath('media:group') || xml_item.at_xpath('media:title') || xml_item.at_xpath('media:content') || xml_item.at_xpath('media:thumbnail') || xml_item.at_xpath('media:description')
      feed_item.attachments << Attachment.new unless feed_item.attachments.first

      titleElement = xml_item.at_xpath('media:title') || xml_item.at_xpath('media:content/media:title') || xml_item.at_xpath('media:group/media:title')
      feed_item.attachments.first.title = titleElement.text if titleElement

      contentElement = xml_item.at_xpath('media:content') || xml_item.at_xpath('media:group/media:content')
      if contentElement
        feed_item.attachments.first.url = contentElement.get('url')
        feed_item.attachments.first.length = contentElement.get('duration')
      end

      thumbnailElement = xml_item.at_xpath('media:thumbnail') || xml_item.at_xpath('media:content/media:thumbnail') || xml_item.at_xpath('media:group/media:thumbnail')
      if thumbnailElement
        thumbnail = Thumbnail.new
        thumbnail.url = thumbnailElement.get('url')
        thumbnail.width = thumbnailElement.get('width')
        thumbnail.height = thumbnailElement.get('height')
        feed_item.attachments.first.thumbnail = thumbnail
      end

      descriptionElement = xml_item.at_xpath('media:description') || xml_item.at_xpath('media:content/media:description') || xml_item.at_xpath('media:group/media:description')
      feed_item.attachments.first.description = descriptionElement.text if descriptionElement
    end
    feed_item
  end # method add_meta_items


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
