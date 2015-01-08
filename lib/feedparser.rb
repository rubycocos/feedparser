# core and stdlibs

require 'rss'
require 'pp'
require 'date'

# 3rd party gems/libs

require 'logutils'

# our own code

require 'feedparser/version'  # let it always go first

require 'feedparser/builder/atom'
require 'feedparser/builder/rss'

require 'feedparser/feed'
require 'feedparser/item'
require 'feedparser/parser'



# say hello
puts FeedParser.banner     if $DEBUG || (defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG)
