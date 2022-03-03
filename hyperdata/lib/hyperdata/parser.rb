# encoding: utf-8


module Hyperdata


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
    @doc = Nokogiri::HTML( @text )

    @feed = ArticleFeedBuilder.build( @doc )
    @feed    # return feed for now  (use a (Hyper)FeedParser instead of "generic" Parser - why? why not?)
  end # method parse


end  # class Parser
end # module Hyperdata
