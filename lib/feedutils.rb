# core and stdlibs

require 'rss'
require 'pp'
require 'date'

# 3rd party gems/libs

require 'logutils'

# our own code

require 'feedutils/version'  # let it always go first

require 'feedutils/builder/atom'
require 'feedutils/builder/rss'

require 'feedutils/helper/atom_v03'

require 'feedutils/feed'
require 'feedutils/item'
require 'feedutils/parser'



# say hello
puts FeedUtils.banner     if $DEBUG || (defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG)
