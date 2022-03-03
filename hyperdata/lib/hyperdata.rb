# encoding: utf-8


# core and stdlibs

require 'json'
require 'date'
require 'time'
require 'pp'


# 3rd party gems/libs
require 'logutils'

require 'nokogiri'


# our own code
require 'hyperdata/version'  # let it always go first

require 'hyperdata/feed'
require 'hyperdata/item'

require 'hyperdata/builder/article'
require 'hyperdata/parser'



# say hello
puts Hyperdata.banner     if $DEBUG || (defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG)
