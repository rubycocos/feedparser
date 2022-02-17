# encoding: utf-8


# core and stdlibs


# 3rd party gems/libs

require 'textutils'

# our own code

require 'feedfinder/version'  # let it always go first


# say hello
puts FeedFinder.banner     if $DEBUG || (defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG)
