# encoding: utf-8


# core and stdlibs

require 'rss'
require 'pp'
require 'time'    # note: ruby has a builtin core time class and a stdlib time class pack; require stdlib extensions
require 'date'    # note: ruby has a builtin core date class and a stdlib date class pack; require stdlib extensions
require 'json'


# 3rd party gems/libs

require 'logutils'
require 'textutils'


# our own code

require 'feedparser/version'  # let it always go first

require 'feedparser/builder/atom'
require 'feedparser/builder/rss'
require 'feedparser/builder/json'
require 'feedparser/builder/microformats'


require 'feedparser/feed'
require 'feedparser/item'
require 'feedparser/author'
require 'feedparser/tag'
require 'feedparser/attachment'
require 'feedparser/thumbnail'
require 'feedparser/generator'
require 'feedparser/parser'



# say hello
puts FeedParser.banner     if $DEBUG || (defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG)
