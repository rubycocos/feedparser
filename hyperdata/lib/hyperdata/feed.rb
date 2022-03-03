# encoding: utf-8

module Hyperdata

class Feed

  attr_accessor :title
  attr_accessor :url        ## todo - add alias site_url/home_page_url/page_url - why? why not??
  attr_accessor :feed_url

  attr_accessor :items

  def initialize
    ## note: make items empty arrays on startup (e.g. not nil)
    @items   = []
  end

end  # class Feed

end # module Hyperdata
