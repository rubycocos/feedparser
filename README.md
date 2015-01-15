# feedparser

feedparser gems - web feed parser and normalizer (RSS 2.0, Atom, etc.)

* home  :: [github.com/feedreader/feed.parser](https://github.com/feedreader/feed.parser)
* bugs  :: [github.com/feedreader/feed.parser/issues](https://github.com/feedreader/feed.parser/issues)
* gem   :: [rubygems.org/gems/feedparser](https://rubygems.org/gems/feedparser)
* rdoc  :: [rubydoc.info/gems/feedparser](http://rubydoc.info/gems/feedparser)
* forum :: [groups.google.com/group/feedreader](http://groups.google.com/group/feedreader)


## Usage

### Structs

Feed • Item

### `Feed` Struct

#### Mappings

Note: use question mark (`?`) for optional elements (otherwise assume required elements)

**Dates**

| Feed Struct        | RSS 2.0           | Notes             | Atom       | Notes           |
| ------------------ | ----------------- | ----------------- | ---------- | --------------- |
| `feed.updated`     | `lastBuildDate`?    | RFC-822 format    | `updated`    | ISO 801 format  |
| `feed.published`   | `pubDate`?          | RFC-822 format    |  -         |                 |

RFC-822 date format e.g. 

ISO-801 date format e.g.

** Title 'n' Summary**

Note: The Feed parser will remove all html tags and attributes from the title (RSS 2.0+Atom), 
description (RSS 2.0) and subtitle (Atom) content and will unescape HTML entities e.g. `&amp;` becomes & and so on.

| Feed Struct        | RSS 2.0           | Notes             | Atom         | Notes           |
| ------------------ | ----------------- | ----------------- | ------------ | --------------- |
| `feed.summary`     | `description`     |                   | `subtitle`   | check if @type w/ html,xhtml,html-escaped possible?  |


~~~
class Feed
  attr_accessor :format   # e.g. atom|rss 2.0|etc.
  attr_accessor :title    # note: always plain vanilla text - if present html tags will get stripped and html entities unescaped
  attr_accessor :url

  attr_accessor :items

  attr_accessor :summary   # note: is description in RSS 2.0 and subtitle in Atom

  attr_accessor :updated     # note: is lastBuildDate in RSS 2.0
  attr_accessor :published   # note: is pubDate in RSS 2.0; not available in Atom

  attr_accessor :generator
  attr_accessor :generator_version  # e.g. @version (atom)
  attr_accessor :generator_uri      # e.g. @uri     (atom) - use alias url/link ???
end
~~~


### `Item` Struct

~~~
class Item
  attr_accessor :title
  attr_accessor :title_type    # optional for now (text|html|html-escaped) - not yet set
  attr_accessor :url           # todo: rename to link (use alias) ??

  attr_accessor :content
  attr_accessor :content_type  # optional for now (text|html|html-escaped|binary-base64) - not yet set

  attr_accessor :summary
  attr_accessor :summary_type  # optional for now (text|html|html-escaped) - not yet set

  attr_accessor :published
  attr_accessor :updated

  attr_accessor :guid     # todo: rename to id (use alias) ??
end
~~~


### Read Feed Example

~~~
require 'open-uri'
require 'feedparser'

xml = open( 'http://openfootball.github.io/atom.xml' ).read

feed = FeedParser::Parser.parse( xml )
pp feed
~~~


## Install

Just install the gem:

    $ gem install feedparser


## License

The `feedparser` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the [Planet Pluto and Friends Forum/Mailing List](http://groups.google.com/group/feedreader).
Thanks!
