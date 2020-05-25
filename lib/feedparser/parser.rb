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
    @head = @text[0..100].strip     # note: remove leading spaces if present
  end



  #### note:
  # make format checks callable from outside (that is, use builtin helper methods)

  def is_xml?
    ## check if starts with knownn xml prologs
    @head.start_with?( '<?xml' )  ||
    @head.start_with?( '<feed' ) ||
    @head.start_with?( '<rss' )
  end
  alias_method :xml?, :is_xml?

  JSONFEED_VERSION_RE = %r{"version":\s*"https://jsonfeed.org/version/1"}
  def is_json?
    ## check if starts with { for json object/hash
    ##    or if includes jsonfeed prolog
    @head.start_with?( '{' ) ||
    @head =~ JSONFEED_VERSION_RE
  end
  alias_method :json?, :is_json?

  def is_microformats?
    #  for now check for microformats v2 (e.g. h-entry, h-feed)
    #    check for v1 too - why? why not? (e.g. hentry, hatom ??)
    @text.include?( 'h-entry' ) ||
    @text.include?( 'h-feed' )
  end
  alias_method :microformats?, :is_microformats?



  def parse
    if is_xml?
       parse_xml
    elsif is_json?
       parse_json
    ##  note: reading/parsing microformat is for now optional
    ##    microformats gem requires nokogiri
    ##       nokogiri (uses libxml c-extensions) makes it hard to install (sometime)
    ##       thus, if you want to use it, please opt-in to keep the install "light"
    elsif defined?( Microformats ) && is_microformats?
       parse_microformats
    else  ## fallback - assume xml for now
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
      feed = AtomFeedBuilder.build( feed_wild, @text )
    else  # -- assume RSS::Rss::Feed
      feed = RssFeedBuilder.build( feed_wild, @text )
    end

    logger.debug "== #{feed.format} / #{feed.title} =="
    feed # return new (normalized) feed
  end  # method  parse_xml

end  # class Parser


end # module FeedParser
