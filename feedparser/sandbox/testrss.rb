
# stdlibs
require 'rss'
require 'pp'

# 3rd party libs/gems
require 'fetcher'

## feed_url = 'http://feeds.feedburner.com/Rubyflow?format=xml'   # rss 2.0

feed_url = 'https://www.nostarch.com/feeds/comingsoon.xml'   # rss 2.0


xml = Fetcher.read( feed_url )

feed = RSS::Parser.parse( xml, false, false )    # use most "liberal" version
# 1) false => do NOT validate
# 2) false => ignore unknown elements   - use true - why? why not??


############
#   format version mappings:
#  RSS::Rss    #rss_version==2.0   => rss 2.0
#              #rss_version==


##################
# RSS::Rss
# - see http://www.ruby-doc.org/stdlib-2.0.0/libdoc/rss/rdoc/RSS/Rss.html

puts "feed.class: #{feed.class.name}"

puts "feed.rss_version: #{feed.rss_version}"
puts "feed.feed_version: #{feed.feed_version}"

puts "feed.image:"
pp feed.image


pp feed
