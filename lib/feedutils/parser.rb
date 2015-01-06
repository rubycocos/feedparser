
module FeedUtils


class Parser

  include LogUtils::Logging

  ### convenience class/factory method
  def self.parse( xml, opts={} )
    self.new( xml ).parse
  end

  ### Note: lets keep/use same API as RSS::Parser for now
  def initialize( xml )
    @xml = xml
    @atomv03helper = AtomV03Helper.new
  end


  def parse
    logger.debug "using stdlib rss/#{RSS::VERSION}"

    ## old (obsolete) Atom Version 0.3 - try to patch/upgrade to 1.0(-ish)
    if @atomv03helper.match?( @xml )
      logger.warn "*** atom v0.3 feed; try to patch/upgrade to 1.0(-ish); please use/find atom v1.0 feed"
      parser = RSS::Parser.new( @atomv03helper.convert( @xml ))
    else
      parser = RSS::Parser.new( @xml )
    end

    parser.do_validate            = false
    parser.ignore_unknown_element = true

    puts "Parsing feed..."
    feed_wild = parser.parse  # not yet normalized

    logger.debug "  feed.class=#{feed_wild.class.name}"

    if feed_wild.is_a?( RSS::Atom::Feed )
      feed = AtomFeedBuilder.build( feed_wild )
    else  # -- assume RSS::Rss::Feed
      feed = RssFeedBuilder.build( feed_wild )
    end

    puts "== #{feed.format} / #{feed.title} =="
    feed # return new (normalized) feed
  end

end  # class Parser


end # module FeedUtils
