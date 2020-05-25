# encoding: utf-8

module FeedParser

class Attachment   ## also known as Enclosure

  attr_accessor :url
  ## note: uri is an alias for url
  alias :uri  :url       ## add atom alias for uri - why? why not?
  alias :uri= :url=

  attr_accessor :length
  attr_accessor :type

  # Elements from the media namespace attachment
  attr_accessor :title
  attr_accessor :thumbnail
  attr_accessor :description
  attr_accessor :community

end  # class Attachment

end # module FeedParser
