# encoding: utf-8

module FeedParser

class Author

  attr_accessor :name
  attr_accessor :url
  ## note: uri is an alias for url
  alias :uri  :url       ## add atom alias for uri - why? why not?
  alias :uri= :url=

  def email?()   @email.nil? == false;  end
  attr_accessor :email

  def avatar?()  @avatar.nil? == false;  end
  attr_accessor :avatar  # todo/check: use avatar_url ?? used by json feed -check if always a url


  ## todo: add role - why? why not?
  ##   e.g. add contributor (atom)
  ##          or managingEditor (rss) or webMaster (rss) - why? why not??

  attr_accessor :text    # note: holds "unparsed" text (content) line form dc:creator or rss:author
  alias :line :text     # line|text  (add str??  too)

  def to_s
    ## note: to_s  - allows to use just author in templates
    ##    will by default return name if present or as fallback "unparsed" text line
     if @name    ## not blank
       @name
     else
       @text
     end
  end

end  # class Author

end # module FeedParser
