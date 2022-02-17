## $:.unshift(File.dirname(__FILE__))


## minitest setup

require 'minitest/autorun'

require 'logutils'
require 'textutils'
require 'fetcher'


## our own code
require 'feedparser'



LogUtils::Logger.root.level = :debug


def fetch_and_parse_feed( url )
  text = Fetcher.read( url )

  FeedParser::Parser.parse( text )
end
