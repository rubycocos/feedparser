# encoding: utf-8

module FeedParser

class Thumbnail

  attr_accessor :url
  
  ## note: uri is an alias for url
  alias :uri  :url       ## add atom alias for uri - why? why not?
  alias :uri= :url=

  def width?()   @width.nil? == false;  end
  attr_accessor :width

  def height?()  @height.nil? == false;  end
  attr_accessor :height  # todo/check: use avatar_url ?? used by json feed -check if always a url

end  # class Thumbnail

end # module FeedParser
