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

![](feed-models.png)

### `Feed` Struct

#### Mappings

Note: uses question mark (`?`) for optional elements (otherwise assume required elements)

**Title 'n' Summary**

Note: The Feed parser will remove all html tags and attributes from the title (RSS 2.0+Atom), 
description (RSS 2.0) and subtitle (Atom) content and will unescape HTML entities e.g. `&amp;` becomes & and so on - always
resulting in plain vanilla text.

| Feed Struct        | RSS 2.0           | Notes               | Atom          | Notes               |
| ------------------ | ----------------- | ------------------- | ------------- | ------------------- |
| `feed.title`       | `title`           | plain vanilla text  | `title`       | plain vanilla text  |
| `feed.summary`     | `description`     | plain vanilla text  | `subtitle`?   | plain vanilla text  |


**Dates**

| Feed Struct        | RSS 2.0             | Notes             | Atom       | Notes           |
| ------------------ | ------------------- | ----------------- | ---------- | --------------- |
| `feed.updated`     | `lastBuildDate`?    | RFC-822 format    | `updated`  | ISO 801 format  |
| `feed.published`   | `pubDate`?          | RFC-822 format    |  -         |                 |

Note: Check - for RSS 2.0 set feed.updated to pubDate or lastBuildDate if only one present? if both present - map as above. 


RFC-822 date format e.g. Wed, 14 Jan 2015 19:48:57 +0100

ISO-801 date format e.g. 2015-01-11T09:30:16Z


~~~
class Feed
  attr_accessor :format   # e.g. atom|rss 2.0|etc.
  attr_accessor :title    # note: always plain vanilla text - if present html tags will get stripped and html entities unescaped
  attr_accessor :url

  attr_accessor :items

  attr_accessor :summary   # note: is description in RSS 2.0 and subtitle in Atom; always plain vanilla text

  attr_accessor :updated     # note: is lastBuildDate in RSS 2.0
  attr_accessor :published   # note: is pubDate in RSS 2.0; not available in Atom

  attr_accessor :generator
  attr_accessor :generator_version  # e.g. @version (atom)
  attr_accessor :generator_uri      # e.g. @uri     (atom) - use alias url/link ???
end
~~~


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

Note: The content element will assume html content.

| Feed Struct        | RSS 2.0           | Notes               | Atom          | Notes               |
| ------------------ | ----------------- | ------------------- | ------------- | ------------------- |
| `item.title`       | `title`           | plain vanilla text  | `title`       | plain vanilla text  |
| `item.summary`     | `description`     | plain vanilla text  | `summary`?    | plain vanilla text  |
| `item.content`     | `content`?        | html                | `content`?    | html                |


**Dates**

| Item Struct        | RSS 2.0             | Notes             | Atom          | Notes           |
| ------------------ | ------------------- | ----------------- | ------------- | --------------- |
| `item.updated`     | `pubDate`?          | RFC-822 format    | `updated`     | ISO 801 format  |
| `item.published`   | -                   | RFC-822 format    | `published`?  | ISO 801 format  |

Note: In plain vanilla RSS 2.0 there's only one `pubDate` for items, thus, it's not possible to differeniate between published and updated dates for items; note - the `item.pubDate` will get mapped to `item.updated`. To set the published date in RSS 2.0 use the dublin core module e.g `dc:created`, for example.

~~~
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
