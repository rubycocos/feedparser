# encoding: utf-8

module FeedParser


class Parser

  include LogUtils::Logging


  ### convenience class/factory method
  def self.parse( text, opts={} )
    self.new( text ).parse
  end

  ### Note: lets keep/use same API as RSS::Parser for now
  def initialize( text )
    @text = text
  end



  def parse
    head = @text[0..100].strip     # note: remove leading spaces if present

    jsonfeed_version_regex = %r{"version":\s*"https://jsonfeed.org/version/1"}

    ## check if starts with knownn xml prologs
    if head.start_with?( '<?xml' )  ||
       head.start_with?( '<feed/' ) ||
       head.start_with?( '<rss/' )
    ## check if starts with { for json object/hash
    ##    or if includes jsonfeed prolog
       parse_xml
    elsif head.start_with?( '{' ) ||
          head =~ jsonfeed_version_regex
       parse_json
    ##  note: reading/parsing microformat is for now optional
    ##    microformats gem requires nokogiri
    ##       nokogiri (uses libxml c-extensions) makes it hard to install (sometime)
    ##       thus, if you want to use it, please opt-in to keep the install "light"
    #
    #  for now check for microformats v2 (e.g. h-entry, h-feed)
    #    check for v1 too - why? why not? (e.g. hentry, hatom ??)
  elsif defined?( Microformats ) &&
          (@text.include?( 'h-entry' ) ||
           @text.include?( 'h-feed' )
           )
      parse_microformats
    else  ## assume xml for now
       parse_xml
    end
  end # method parse


  def parse_microformats
    logger.debug "using microformats/#{Microformats::VERSION}"

    logger.debug "Parsing feed in html (w/ microformats)..."

    collection = Microformats.parse( @text )
    collection_hash = collection.to_hash

    feed = HyFeedBuilder.build( collection_hash )

    logger.debug "== #{feed.format} / #{feed.title} =="
    feed # return new (normalized) feed
  end # method parse_microformats


  def parse_json
    logger.debug "using stdlib json/#{JSON::VERSION}"

    logger.debug "Parsing feed in json..."
    feed_hash = JSON.parse( @text )

    feed = JsonFeedBuilder.build( feed_hash )

    logger.debug "== #{feed.format} / #{feed.title} =="
    feed # return new (normalized) feed
  end # method parse_json


  def parse_xml
    logger.debug "using stdlib rss/#{RSS::VERSION}"

    parser = RSS::Parser.new( @text )

    parser.do_validate            = false
    parser.ignore_unknown_element = true

    logger.debug "Parsing feed in xml..."
    feed_wild = parser.parse  # not yet normalized

    logger.debug "  feed.class=#{feed_wild.class.name}"

    if feed_wild.is_a?( RSS::Atom::Feed )
      feed = AtomFeedBuilder.build( feed_wild )
    else  # -- assume RSS::Rss::Feed
      feed = RssFeedBuilder.build( feed_wild )
    end

    logger.debug "== #{feed.format} / #{feed.title} =="
    feed # return new (normalized) feed
  end  # method  parse_xml

end  # class Parser


end # module FeedParser
