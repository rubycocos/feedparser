# encoding: utf-8

module FeedParser

class Attachment   ## also known as Enclosure

  attr_accessor :url
  ## note: uri is an alias for url
  alias :uri  :url       ## add atom alias for uri - why? why not?
  alias :uri= :url=

  attr_accessor :length
  attr_accessor :type

end  # class Attachment

end # module FeedParser
