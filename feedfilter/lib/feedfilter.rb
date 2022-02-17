# encoding: utf-8


# core and stdlibs


# 3rd party gems/libs

require 'textutils'

# our own code

require 'feedfilter/version'  # let it always go first
require 'feedfilter/ads'
require 'feedfilter/includes'


# say hello
puts FeedFilter.banner     if $DEBUG || (defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG)

