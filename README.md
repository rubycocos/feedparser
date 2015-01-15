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

**Mappings**

Note: use question mark (?) for optional elements (otherwise assume required elements)

Dates

| Feed Struct        | RSS 2.0           | Notes           | Atom       | Notes           |
| updated            | lastBuildDate?    | RFC-822 format  | updated    | ISO 801 format  |
| published          | pubDate?          | RFC-822 format  |  -         |                 |

RFC-822 date format e.g. 
ISO-801 date format e.g.

Summary


~~~
class Feed
  attr_accessor :format   # e.g. atom|rss 2.0|etc.
  attr_accessor :title
  attr_accessor :title_type  # e.g. text|html|html-escaped  (optional) -use - why?? why not??
  attr_accessor :url

  attr_accessor :items

  attr_accessor :summary        # e.g. description (rss)
  attr_accessor :summary_type   # e.g. text|html|html-escaped

  attr_accessor :title2         # e.g. subtitle (atom)
  attr_accessor :title2_type    # e.g. text|html|html-escaped

  attr_accessor :published
  attr_accessor :updated
  attr_accessor :built

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
