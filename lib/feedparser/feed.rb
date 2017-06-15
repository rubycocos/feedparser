# encoding: utf-8

module FeedParser

class Feed

  attr_accessor :format   # e.g. atom|rss 2.0|json etc.
  attr_accessor :title
  attr_accessor :url        ## todo - add alias site_url/home_page_url/page_url - why? why not??
  attr_accessor :feed_url


  attr_accessor :items

  attr_accessor :authors
  def authors?()  @authors && @authors.size > 0;  end
  ## note: author? is an alias for authors?
  alias :author? :authors?

  ## add author  shortcut e.g. equals authors[0] - for now only read only
  ##   fix: also add author=  why? why not???
  def author() @authors[0]; end


  attr_accessor :tags
  def tags?()  @tags && @tags.size > 0;  end

  ## add alias category for tags (remove - why? why not?)
  alias :categories :tags


  def summary?()  @summary.nil? == false;  end
  attr_accessor :summary        # e.g. description (rss)|subtitle (atom)

  ## add description as alias for summary (remove - why? why not?)
  alias :description  :summary
  alias :description= :summary=
  alias :description? :summary?


  ##
  ##  todo/check/fix:
  ##     use a extra field for atom subtitle
  ##      - subtitle not the same as summary - why? why not?
  ##      -  assume summary == description == abstract but
  ##            keep subtitle separate e.g. assume subtitle is just a (simple) single line
  ##
  ##  for now alias summary to subtitle
  alias :subtitle  :summary
  alias :subtitle= :summary=
  alias :subtitle? :summary?



  def updated?()  @updated.nil? == false;  end
  attr_accessor :updated        # e.g. lastBuildDate (rss)|updated (atom)   -- always (converted) to utc
  attr_accessor :updated_local  # "unparsed" local datetime as in feed (NOT converted to utc)

  attr_accessor :updated_text    #  string version of date
  alias :updated_line :updated_text   # text|line - convention for "unparsed" 1:1 from feed; add str(too ??)

  def published?()  @published.nil? == false;  end
  attr_accessor :published         # e.g. pubDate (rss)\n/a (atom)  -- note: published is basically an alias for created
  attr_accessor :published_local   # "unparsed" local datetime as in feed (NOT converted to utc)

  attr_accessor :published_text    #  string version of date
  alias :published_line :published_text   # text|line - convention for "unparsed" 1:1 from feed; add str(too ??)


  attr_accessor :generator


  ## fix:
  #  add pretty printer/inspect (exclude object)


  def initialize
    ## note: make items, authors, tags empty arrays on startup (e.g. not nil)
    @items   = []
    @authors = []
    @tags    = []

    @generator = Generator.new
  end

end  # class Feed

end # module FeedParser
