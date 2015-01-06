## $:.unshift(File.dirname(__FILE__))


## minitest setup

require 'minitest/autorun'

require 'logutils'
require 'fetcher'

## our own code

require 'feedutils'


LogUtils::Logger.root.level = :debug

def parse_feed( url )
  xml = Fetcher.read( url )

  FeedUtils::Parser.parse( xml )
end



def read_feed_from_file( name )
  File.read( "#{FeedUtils.root}/test/feeds/#{name}")
end

def parse_feed_from_file( name )
  xml = read_feed_from_file( name )

  FeedUtils::Parser.parse( xml )  
end

