# encoding: utf-8

module FeedParser

class Tag

  attr_accessor :name
  ## note: title n term are aliases for name
  alias :title  :name
  alias :title= :name=

  alias :term   :name
  alias :term=  :name=


  attr_accessor :scheme    ## use scheme_url -why? why not? is it always a url/uri??
  ## note: domain (rss) is an alias for scheme (atom)
  alias :domain   :scheme
  alias :domain=  :scheme=

end  # class Tag

end # module FeedParser
