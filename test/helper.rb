## $:.unshift(File.dirname(__FILE__))


## minitest setup

require 'minitest/autorun'

require 'logutils'
require 'fetcher'

## our own code

require 'feedparser'


LogUtils::Logger.root.level = :debug

def parse_feed( url )
  xml = Fetcher.read( url )

  FeedParser::Parser.parse( xml )
end



def read_feed_from_file( name )
  File.read( "#{FeedParser.root}/test/feeds/#{name}")
end

def parse_feed_from_file( name )
  xml = read_feed_from_file( name )

  FeedParser::Parser.parse( xml )  
end

