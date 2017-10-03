# feedparser

feedparser gem - web feed parser and normalizer (Atom, RSS, JSON Feed, HTML h-entry, etc.)

* home  :: [github.com/feedparser/feedparser](https://github.com/feedparser/feedparser)
* bugs  :: [github.com/feedparser/feedparser/issues](https://github.com/feedparser/feedparser/issues)
* gem   :: [rubygems.org/gems/feedparser](https://rubygems.org/gems/feedparser)
* rdoc  :: [rubydoc.info/gems/feedparser](http://rubydoc.info/gems/feedparser)
* forum :: [groups.google.com/group/wwwmake](http://groups.google.com/group/wwwmake)


## What's News?

**October/2017**: Added support for attachments / media enclosures in RSS and Atom.

**June/2017**:  Added support for reading feeds in HTML with Microformats incl.
[`h-entry`](http://microformats.org/wiki/h-entry),
[`h-feed`](http://microformats.org/wiki/h-feed) and others.

All feed with test assertions for easy (re)use and browsing moved
to its own repo, that is, [`/feeds`](https://github.com/feedparser/feeds).

**May/2017**: Added support for reading feeds in the new [JSON Feed](https://jsonfeed.org) format in - surprise, surprise - JSON.


## What's a Web Feed?

See the [Awesome Feeds](https://github.com/feedparser/awesome-feeds) page ».



## Usage


### Structs

Feed • Item • Author • Tag • Attachment • Generator


![](feed-models.png)

### `Feed` Struct

#### Mappings

Note: uses question mark (`?`) for optional elements (otherwise assume required elements)

**Title 'n' Summary**

Note: The Feed parser will remove all html tags and attributes from the title (RSS 2.0+Atom),
description (RSS 2.0) and subtitle (Atom) content and will unescape HTML entities e.g. `&amp;` becomes & and so on - always
resulting in plain vanilla text.

| Feed Struct        | RSS 2.0           | Notes       | Atom          | Notes       | JSON            | Notes       |
| ------------------ | ----------------- | ----------- | ------------- | ----------- | --------------- | ----------- |
| `feed.title`       | `title`           | plain text  | `title`       | plain text  | `title`         | plain text  |
| `feed.summary`     | `description`     | plain text  | `subtitle`?   | plain text  | `description`?  | plain text  |


**Dates**

| Feed Struct        | RSS 2.0             | Notes             | Atom       | Notes           |
| ------------------ | ------------------- | ----------------- | ---------- | --------------- |
| `feed.updated`     | `lastBuildDate`?    | RFC-822 format    | `updated`  | ISO 801 format  |
| `feed.published`   | `pubDate`?          | RFC-822 format    |  -         |                 |

Note: Check - for RSS 2.0 set feed.updated to pubDate or lastBuildDate if only one present? if both present - map as above.


RFC-822 date format e.g. Wed, 14 Jan 2015 19:48:57 +0100

ISO-801 date format e.g. 2015-01-11T09:30:16Z


``` ruby
class Feed
  attr_accessor :format   # e.g. atom|rss 2.0|etc.
  attr_accessor :title    # note: always plain vanilla text - if present html tags will get stripped and html entities unescaped
  attr_accessor :url

  attr_accessor :items

  attr_accessor :summary   # note: is description in RSS 2.0 and subtitle in Atom; always plain vanilla text

  attr_accessor :updated     # note: is lastBuildDate in RSS 2.0
  attr_accessor :published   # note: is pubDate in RSS 2.0; not available in Atom

  attr_accessor :authors
  attr_accessor :tags
  attr_accessor :generator
end
```

(Source: [`lib/feedparser/feed.rb`](https://github.com/feedparser/feedparser/blob/master/lib/feedparser/feed.rb))


### `Item` Struct

**Title 'n' Summary**

Note: The Feed parser will remove all html tags and attributes from the title (RSS 2.0+Atom),
description (RSS 2.0) and summary (Atom) content
and will unescape HTML entities e.g. `&amp;` becomes & and so on - always
resulting in plain vanilla text.

Note: In plain vanilla RSS 2.0 there's no difference between (full) content and summary - everything is wrapped
in a description element; however, best practice is using the content "module" from RSS 1.0 inside RSS 2.0.
If there's no content module present the feed parser will "clone" the description and use one version for `item.summary` and
the clone for `item.content`.

Note: In JSON Feed the title is not required (that is, is optional). The idea is to support "modern" micro blog postings (tweets, toots, etc.) that have no titles.  The JSON Feed supports `content_html` and/or `content_text`. At least one version must be present.

<!-- todo: update JSON Feed comments - add support for content_text - now just uses content_html - why? why not??  
  -->

Note: The content element will assume html content.

| Feed Struct        | RSS 2.0           | Notes       | Atom          | Notes       | JSON               | Notes       |
| ------------------ | ----------------- | ----------- | ------------- | ----------- | -----------------  | ----------- |  
| `item.title`       | `title`           | plain text  | `title`       | plain text  |  `title`?          | plain text  |
| `item.summary`     | `description`     | plain text  | `summary`?    | plain text  |   -tbd-            |             |
| `item.content`     | `content`?        | html        | `content`?    | html        |  `content_html (*)`| html        |


**Dates**

| Item Struct        | RSS 2.0             | Notes             | Atom          | Notes           |
| ------------------ | ------------------- | ----------------- | ------------- | --------------- |
| `item.updated`     | `pubDate`?          | RFC-822 format    | `updated`     | ISO 801 format  |
| `item.published`   | -                   | RFC-822 format    | `published`?  | ISO 801 format  |

Note: In plain vanilla RSS 2.0 there's only one `pubDate` for items, thus, it's not possible to differeniate between published and updated dates for items; note - the `item.pubDate` will get mapped to `item.updated`. To set the published date in RSS 2.0 use the dublin core module e.g `dc:created`, for example.

``` ruby
class Item
  attr_accessor :title   # note: always plain vanilla text - if present html tags will get stripped and html entities
  attr_accessor :url

  attr_accessor :content
  attr_accessor :content_type  # optional for now (text|html|html-escaped|binary-base64) - not yet set

  attr_accessor :summary

  attr_accessor :updated    # note: is pubDate in RSS 2.0 and updated in Atom
  attr_accessor :published  # note: is published in Atom; not available in RSS 2.0 (use dc:created ??)

  attr_accessor :guid     # todo: rename to id (use alias) ??
end
```

(Source: [`lib/feedparser/item.rb`](https://github.com/feedparser/feedparser/blob/master/lib/feedparser/item.rb))


### `Author` Struct

(Source: [`lib/feedparser/author.rb`](https://github.com/feedparser/feedparser/blob/master/lib/feedparser/author.rb))


### `Tag` Struct

(Source: [`lib/feedparser/tag.rb`](https://github.com/feedparser/feedparser/blob/master/lib/feedparser/tag.rb))

### `Attachment`  Struct

_Also known as Media Enclosure_

(Source: [`lib/feedparser/attachment.rb`](https://github.com/feedparser/feedparser/blob/master/lib/feedparser/attachment.rb))


### `Generator` Struct

(Source: [`lib/feedparser/generator.rb`](https://github.com/feedparser/feedparser/blob/master/lib/feedparser/generator.rb))




### Read Feed Example

``` ruby
require 'open-uri'
require 'feedparser'

txt = open( 'http://openfootball.github.io/feed.xml' ).read

feed = FeedParser::Parser.parse( txt )

puts feed.title
# => "football.db - Open Football Data"

puts feed.url
# => "http://openfootball.github.io/"

puts feed.items[0].title
# => "football.db - League Quick Starter Sample - Mauritius Premier League - Create Your Own Repo/League(s) from Scratch"

puts feed.items[0].url
# => "http://openfootball.github.io/2015/08/30/league-quick-starter.html"

puts feed.items[0].updated
# => Sun, 30 Aug 2015 00:00:00 +0000

puts feed.items[0].content
# => "Added a new quick starter sample using the Mauritius Premier League to get you started..."

...
```

or reading a feed in the new [JSON Feed](https://jsonfeed.org) format in - surprise, surprise - JSON;
note: nothing changes :-)

``` ruby
txt = open( 'http://openfootball.github.io/feed.json' ).read

feed = FeedParser::Parser.parse( txt )

puts feed.title
# => "football.db - Open Football Data"

puts feed.url
# => "http://openfootball.github.io/"

puts feed.items[0].title
# => "football.db - League Quick Starter Sample - Mauritius Premier League - Create Your Own Repo/League(s) from Scratch"

puts feed.items[0].url
# => "http://openfootball.github.io/2015/08/30/league-quick-starter.html"

puts feed.items[0].updated
# => Sun, 30 Aug 2015 00:00:00 +0000

puts feed.items[0].content_text
# => "Added a new quick starter sample using the Mauritius Premier League to get you started..."

...
```

### Microformats

Microformats let you mark up feeds and posts in HTML with
[`h-entry`](http://microformats.org/wiki/h-entry),
[`h-feed`](http://microformats.org/wiki/h-feed),
and friends.

Note: Microformats support in feedparser is optional.
Install and require the the [microformats gem](https://github.com/indieweb/microformats-ruby) to read
feeds in HTML with Microformats.


``` ruby

require 'microformats'

text =<<HTML
<article class="h-entry">
  <h1 class="p-name">Microformats are amazing</h1>
  <p>Published by
    <a class="p-author h-card" href="http://example.com">W. Developer</a>
     on <time class="dt-published" datetime="2013-06-13 12:00:00">13<sup>th</sup> June 2013</time>

  <p class="p-summary">In which I extoll the virtues of using microformats.</p>

  <div class="e-content">
    <p>Blah blah blah</p>
  </div>
</article>
HTML

feed = FeedParser::Parser.parse( text )

puts feed.format
# => "html"
puts feed.items.size
# =>  1
puts feed.items[0].authors.size
# => 1
puts feed.items[0].content_html  
# => "<p>Blah blah blah</p>"
puts feed.items[0].content_text  
# => "Blah blah blah"
puts feed.items[0].title
# => "Microformats are amazing"
puts feed.items[0].summary
# => "In which I extoll the virtues of using microformats."
puts feed.items[0].published
# => 2013-06-13 12:00:00
puts feed.items[0].authors[0].name
# => "W. Developer"
...
```

## Samples

### Feed Reader

_Planet Feed Reader in 20 Lines of Ruby_

`planet.rb`:

``` ruby
require 'open-uri'
require 'feedparser'
require 'erb'

# step 1) read a list of web feeds

FEED_URLS = [
  'http://vienna-rb.at/atom.xml',
  'http://weblog.rubyonrails.org/feed/atom.xml',
  'http://www.ruby-lang.org/en/feeds/news.rss',
  'http://openfootball.github.io/feed.json',
]

items = []

FEED_URLS.each do |url|
  feed = FeedParser::Parser.parse( open( url ).read )
  items += feed.items
end

# step 2) mix up all postings in a new page

FEED_ITEM_TEMPLATE = <<EOS
<% items.each do |item| %>
  <div class="item">
    <h2><a href="<%= item.url %>"><%= item.title %></a></h2>
    <div><%= item.content %></div>
  </div>
<% end %>
EOS

puts ERB.new( FEED_ITEM_TEMPLATE ).result
```

Run the script:

```
$ ruby ./planet.rb      
```

Prints:

```
<div class="item">
  <h2><a href="http://vienna-rb.at/blog/2017/11/06/picks/">Picks / what the vienna.rb team thinks is worth sharing this week</a></h2>
  <div>
   <h3>6/11 Picks!!</h3>
   <p>In a series on this website we'll entertain YOU with our picks...
 ...
```

## Real World Usage

See the Planet Pluto feed reader family:

- [Planet Pluto](https://github.com/feedreader)  - static planet website generator
- [Planet Pluto Live](https://github.com/plutolive) - dynamic (live) planet web apps (using Sinatra, Rails, etc.)


Add your tools, scripts, apps here! Let us know.



## Install

Just install the gem:

    $ gem install feedparser


## License

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The `feedparser` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the [wwwmake Forum/Mailing List](http://groups.google.com/group/wwwmake).
Thanks!
