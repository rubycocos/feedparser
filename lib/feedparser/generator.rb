# encoding: utf-8

module FeedParser

class Generator

  attr_accessor :name
  ## note: title is an alias for name
  alias :title  :name
  alias :title= :name=

  attr_accessor :version

  attr_accessor :url
  ## note: uri is an alias for url
  alias :uri  :url       ## add atom alias for uri - why? why not?
  alias :uri= :url=


  attr_accessor :text  # note: holds "unparsed" text (content) line form rss:generator
  alias :line :text    # line|text (add str?? too)


  def to_s
    ## note: to_s  - allows to use just generator in templates
    ##    will by default return name if present or as fallback "unparsed" text line
     if @name    ## not blank
       @name
     else
       @text
     end
  end

end  # class Generator

end # module FeedParser
