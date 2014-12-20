## $:.unshift(File.dirname(__FILE__))


## minitest setup

require 'minitest/autorun'

require 'logutils'
require 'fetcher'

## our own code

require 'feedutils'


LogUtils::Logger.root.level = :debug

def parse_feed( feed_url )
  xml = Fetcher.read( feed_url )

  FeedUtils::Parser.parse( xml )
end
