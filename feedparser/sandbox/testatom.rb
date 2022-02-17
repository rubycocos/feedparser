
# stdlibs
require 'rss'
require 'pp'

# 3rd party libs/gems
require 'fetcher'

## feed_url = 'http://weblog.rubyonrails.org/feed/atom.xml'   # atom 1.0

## feed_url = 'http://www.quirksmode.org/blog/atom.xml'  # atom 0.3 (!)

feed_url = 'http://intertwingly.net/blog/index.atom'


xml = Fetcher.read( feed_url )

feed = RSS::Parser.parse( xml, false, true )
# 1) false => do NOT validate  (otherwise atom 0.3 fails)
# 2) true => ignore unknown elements   - use true - why? why not??

# Note: default is true,true - that is, do validate, and do ignore unknown elements


############
#    format version mappings:
#  RSS::Atom::Feed   => atom


###########
# Note: RSS::Atom::Feed
#   - has no feed_version  => assumes always 1.0 for now (no other atom format exists)



##################
# RSS::Rss
# - see http://www.ruby-doc.org/stdlib-2.0.0/libdoc/rss/rdoc/RSS/Rss.html

puts "feed.class: #{feed.class.name}"


## puts "dump feed:"
## pp feed

# puts "dump feed.channel:"
# puts feed.channel.inspect

puts "dump feed.title (#{feed.title.class.name}):"
## pp feed.title

puts "dump feed.id (#{feed.id.class.name}):"
## pp feed.id

puts "dump feed.updated (#{feed.updated.class.name}):"
## pp feed.updated

=begin
@link=
  [#<RSS::Atom::Feed::Link:0x8c90c7c
    @base=nil,
    @converter=nil,
    @do_validate=true,
    @href="http://weblog.rubyonrails.org/feed/",
    @hreflang=nil,
    @lang=nil,
    @length=nil,
    @parent=#<RSS::Atom::Feed:0x8c9c2d4 ...>,
    @rel="self",
    @title=nil,
    @type="application/atom+xml">,
   #<RSS::Atom::Feed::Link:0x8c8cec4
    @base=nil,
    @converter=nil,
    @do_validate=true,
    @href="http://weblog.rubyonrails.org/",
    @hreflang=nil,
    @lang=nil,
    @length=nil,
    @parent=#<RSS::Atom::Feed:0x8c9c2d4 ...>,
    @rel="alternate",
    @title=nil,
    @type="text">],
=end

# check links (assume it's any array - always)
puts "dump feed.link (#{feed.link.class.name}):"
puts "  link rel=#{feed.link.rel} type=#{feed.link.type} href=#{feed.link.href}"

## Note: use links (with s - plural to get back array)
puts "dump feed.links (#{feed.links.class.name}):"

feed.links.each_with_index do |link,i|
  puts "[#{i}] link rel=#{link.rel} type=#{link.type} href=#{link.href}"
end


## todo/check: atom feed can include published element (optionaly)?

if feed.respond_to?( :published )
  puts "dump feed.published (#{feed.published.class.name}):"
  ## pp feed.published
end


pp feed
