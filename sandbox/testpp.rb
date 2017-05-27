
require 'logutils'
require 'textutils'
require 'fetcher'


## our own code

require 'feedparser'


## LogUtils::Logger.root.level = :debug

feed_url = "http://openfootball.github.io/feed.json"

text = Fetcher.read( feed_url )
feed = FeedParser::Parser.parse( text )

pp feed

puts feed.title
