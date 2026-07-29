require 'rss'
require 'open-uri'
require 'pp'

url = 'http://feeds.nature.com/nphys/rss/current'
txt = URI.open( url ).read

feed = RSS::Parser.parse( txt )
pp feed
puts "---"

puts "Title: #{feed.channel.title}"
feed.items.each do |item|
    puts "Item: #{item.title}"
end

##################### 
##  try feedparser
require 'feedparser'

feed = FeedParser::Parser.parse( txt )
pp feed

parser = FeedParser::Parser.new( txt )
pp parser.xml?
pp parser.json?
pp parser.microformats?

puts "bye"