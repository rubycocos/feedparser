# encoding: utf-8

module FeedParser

### todo/fix:
#    rename to Rss20FeedBuilder?? or FeedBuilderRss20 ??

class RssFeedBuilder

  include LogUtils::Logging


  def self.build( rss_feed, raw )
    feed = self.new( rss_feed, raw )
    feed.to_feed
  end

  def initialize( rss_feed, raw )
    @feed = build_feed( rss_feed, raw )
  end

  def to_feed
    @feed
  end



  def build_feed( rss_feed, raw )
    feed = Feed.new
    feed.format = "rss #{rss_feed.rss_version}"

    logger.debug "  rss | feed.version  >#{rss_feed.rss_version}<"

    feed.title     = handle_content( rss_feed.channel.title,       'feed.title'       )  # required
    feed.summary   = handle_content( rss_feed.channel.description, 'feed.description => summary' )  # required
    feed.url       = rss_feed.channel.link            # required

    begin
        feed.updated_local   = handle_date( rss_feed.channel.lastBuildDate, 'feed.lastBuildDate => updated' )  # optional
    rescue
    end
    feed.updated         = feed.updated_local.utc     if feed.updated_local

    begin
        feed.published_local = handle_date( rss_feed.channel.pubDate,       'feed.pubDate => published'     )  # optional
    rescue
    end
    feed.published       = feed.published_local.utc   if feed.published_local

    begin
        logger.debug "  rss | feed.generator  >#{rss_feed.channel.generator}< : #{rss_feed.channel.generator.class.name}"
    rescue
    end

    begin
        feed.generator.text = rss_feed.channel.generator    # optional
    rescue
    end
    feed.generator.name = feed.generator.text   ## note: for now set also name/title to "unparsed" (content) line (may change in the future!!!)



    ## check for managingEditor and/or  webMaster

    if rss_feed.channel.respond_to?(:managingEditor) && rss_feed.channel.managingEditor
      author = Author.new
      author.text = rss_feed.channel.managingEditor.strip
      author.name = author.text   ## note: for now use "unparsed" (content) line also for name
      feed.authors << author
    end

    ## todo/check - if tag is called webmaster or webMaster ???
    if rss_feed.channel.respond_to?(:webMaster) && rss_feed.channel.webMaster
      author = Author.new
      author.text = rss_feed.channel.webMaster.strip
      author.name = author.text   ## note: for now use "unparsed" (content) line also for name
      feed.authors << author
    end


    ## check for dublin core (dc) metadata

    if rss_feed.channel.dc_creator
      ## note: dc_creator wipes out authors if set with rss tag(s)
      authors = []
      authors << build_author_from_dublic_core_creator( rss_feed.channel.dc_creator )
      feed.authors = authors
    end


    ###  check for categories (tags)
    if rss_feed.channel.respond_to?(:categories)
        rss_feed.channel.categories.each do |rss_cat|
          feed.tags << build_tag( rss_cat )
        end
    end


    rss_feed.items.each do |rss_item|
      feed.items << build_item( rss_item )
    end

    if defined?( Oga )
      parsed_xml = Oga.parse_xml( raw )
      xml_items = parsed_xml.xpath( '/rss/channel/item' )
      xml_items.each_with_index do |xml_item, i|
        feed.items[i] = add_meta_items( feed.items[i], xml_item )
      end
    end

    feed # return new feed
  end


  def build_author_from_dublic_core_creator( dc_creator )
    author = Author.new
    author.text = dc_creator.strip
    author.name = author.text    # note: for now use "unparsed" creator line also for name (may change in the future!!!)
    author
  end



  def build_tag( rss_cat )
    ## pp rss_cat
    tag = Tag.new

    ## note: always strip leading n trailing spaces
    ##         and add if preset (not blank/empty e.g. not nil or "")
    tag.name     = rss_cat.content.strip    if rss_cat.content
    tag.domain   = rss_cat.domain.strip     if rss_cat.domain

    tag
  end  # build_tag



  def build_item( rss_item )

    item = Item.new

    item.title     = handle_content( rss_item.title, 'item.title' )
    item.url       = rss_item.link

    logger.debug "  rss | item.link  >#{rss_item.link}< : #{rss_item.link.class.name}"


## todo:
##  check if feedburner:origLink present - if yes, use it for url/link
##  example: use
##  - <feedburner:origLink>http://www.rubyflow.com/items/9803-gotta-ruby-s-syntax</feedburner:origLink></item>
##   instead of
##  - <link>http://feedproxy.google.com/~r/Rubyflow/~3/Ym9Sltg_2_c/9803-gotta-ruby-s-syntax</link>


    item.summary   = handle_content( rss_item.description, 'item.description => summary' )

    # check for <content:encoded>
    # -- using RSS 1.0 content module in RSS 2.0
    item.content = rss_item.content_encoded
    logger.debug "  rss | item.content_encoded[0..40]  >#{rss_item.content_encoded ? rss_item.content_encoded[0..40] : ''}< : #{rss_item.content_encoded.class.name}"

    begin
        item.published_local   = handle_date( rss_item.pubDate, 'item.pubDate => published' )
    rescue
    end
    item.published         = item.published_local.utc    if item.published_local


    ## fix/todo: check if rss_item.guid present? !!!!
    ##
    ##  might be the case e.g. check lambda-the-ultimate.org, for example

    if rss_item.respond_to?(:guid) && rss_item.guid && rss_item.guid.content
      item.guid     = rss_item.guid.content
      logger.debug "  rss | item.guid.content  >#{rss_item.guid.content}< : #{rss_item.guid.content.class.name}"
    else
      item.guid     = rss_item.link
      logger.warn "  rss | item.guid.content missing !!!! - using link for guid"
    end


    if rss_item.respond_to?(:author) && rss_item.author
      author = Author.new
      author.text = rss_item.author.strip
      author.name = author.text   ## note: for now use "unparsed" (content) line also for name
      item.authors << author
    end


    ## check for dublin core (dc) metadata

    if rss_item.dc_creator
      ## note: dc_creator wipes out authors if set with rss tag(s)
      authors = []
      authors << build_author_from_dublic_core_creator( rss_item.dc_creator )
      item.authors = authors
    end

    unless item.published_local
        # use dc_date only of no regular item date was given
        begin
            item.published_local   = handle_date( rss_item.dc_date, 'item.dc_date => published' )
        rescue
        end
        item.published         = item.published_local.utc    if item.published_local
    end

    ###  check for categories (tags)
    if rss_item.respond_to?(:categories)
        rss_item.categories.each do |rss_cat|
          item.tags << build_tag( rss_cat )
        end
    end


    ## check for enclosure
    ##   todo/check: rss can only include at most one enclosure?

    if rss_item.respond_to?(:enclosure) && rss_item.enclosure
      attachment = Attachment.new
      attachment.url    = rss_item.enclosure.url
      attachment.length = rss_item.enclosure.length
      attachment.type   = rss_item.enclosure.type
      item.attachments << attachment
    end

    item
  end # method build_feed_item_from_rss


  # Add additional elements, currently the media: namespace elements
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

    # NOTE:
    # All date-times in RSS conform
    #   to the Date and Time Specification of RFC 822
    #  e.g. Sun, 19 May 2012 15:21:36 GMT  or
    #       Sat, 07 Sep 2013 00:00:01 GMT

    ## convert from time to to_datetime  (avoid errors on windows w/ builtin rss lib)

    logger.debug "  rss | #{name}  >#{el}< : #{el.class.name}"


    ## convert from time to to_datetime  (avoid errors on windows w/ builtin rss lib)
    date = if el.nil?
             nil
           else
             el.to_datetime
           end

    date
  end

  def handle_content( el, name )
    ## note:
    #   use for feed.title, feed.description
    #           item.title, item.description
    #
    # do NOT use for others e.g. feed.generator, etc.


    ## todo/fix: strip html tags n attributes ???

    logger.debug "  rss | #{name}  >#{el}< : #{el.class.name}"

    text = if el.nil?
             nil
           else
             el.strip
           end
    text
  end


end # class RssFeedBuilder
end # module FeedParser
