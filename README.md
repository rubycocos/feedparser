# feedutils

feedutils gems - web feed parser and normalizer (RSS 2.0, Atom, etc.)

* home  :: [github.com/rubylibs/feedutils](https://github.com/rubylibs/feedutils)
* bugs  :: [github.com/rubylibs/feedutils/issues](https://github.com/rubylibs/feedutils/issues)
* gem   :: [rubygems.org/gems/feedutils](https://rubygems.org/gems/feedutils)
* rdoc  :: [rubydoc.info/gems/feedutils](http://rubydoc.info/gems/feedutils)
* forum :: [groups.google.com/group/feedreader](http://groups.google.com/group/feedreader)


## Usage

### Structs

Feed • Item

### `Feed` Struct

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
require 'feedutils'

xml = open( 'http://openfootball.github.io/atom.xml' ).read

feed = FeedUtils::Parser.parse( xml )
pp feed
~~~



## Alternatives

- [`syndication`](http://syndication.rubyforge.org) [(Source)](https://github.com/lpar/syndication) - by Mathew (aka lpar);  RSS 1.0, 2.0, Atom, and understands namespaces; optional support for Dublin Core, iTunes/podcast feeds, and RSS 1.0 Syndication and Content modules
- [`simple-rss`](http://rubyforge.org/projects/simple-rss)
- [`feedtools`](http://rubyforge.org/projects/feedtools)

TBD


## License

The `feedutils` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.

