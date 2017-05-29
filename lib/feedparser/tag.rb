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

end  # class Tag

end # module FeedParser
