# encoding: utf-8

module FeedParser

class Item

  attr_accessor :title
  attr_accessor :url
  attr_accessor :external_url

  # note: related_url is an alias for external_url
  alias :related_url  :external_url     ## link rel=related used in atom
  alias :related_url= :external_url=


  ## note: only content/content_html should use html;
  ##  all others (e.g. title/summary/content_text) shoud be plain (vanilla) text


  def content?()  @content.nil? == false;  end
  attr_accessor  :content

  ## note: content_html is an alias for content
  ##   will hold type html/xhtml/html-escaped  - check if always converted to string by parser ??
  alias :content_html  :content
  alias :content_html= :content=
  alias :content_html? :content?


  def content_text?()  @content_text.nil? == false;  end
  attr_accessor  :content_text



  def summary?()  @summary.nil? == false;  end
  attr_accessor   :summary

  ## add description as alias for summary (remove - why? why not?)
  alias :description  :summary
  alias :description= :summary=
  alias :description? :summary?



  def updated?()  @updated.nil? == false;  end
  attr_accessor :updated   # pubDate (RSS)|updated (Atom)
  attr_accessor :updated_local  # "unparsed" local datetime as in feed (NOT converted to utc)

  attr_accessor :updated_text    #  string version of date
  alias :updated_line :updated_text   # text|line - convention for "unparsed" 1:1 from feed; add str(too ??)


  def published?()  @published.nil? == false;  end
  attr_accessor :published  # note: published is basically an alias for created
  attr_accessor :published_local   # "unparsed" local datetime as in feed (NOT converted to utc)

  attr_accessor :published_text    #  string version of date
  alias :published_line :published_text   # text|line - convention for "unparsed" 1:1 from feed; add str(too ??)


  attr_accessor :id

  ## note: guid is an alias for id
  alias :guid  :id
  alias :guid= :id=

  attr_accessor :authors
  ## add author  shortcut e.g. equals authors[0] - for now only read only
  ##   fix: also add author=  why? why not???
  def authors?()  @authors && @authors.size > 0;  end
  ## note: author? is an alias for authors?
  alias :author? :authors?

  ## add author  shortcut e.g. equals authors[0] - for now only read only
  ##   fix: also add author=  why? why not???
  def author() @authors[0]; end


  attr_accessor :tags
  def tags?()  @tags && @tags.size > 0;  end

  alias :categories :tags    # for now allow categories alias for tags - remove (why? why not?)


  # add attachments/media enclosures (url, length and type)
  #  note: lets support more than one (it's an array)
  attr_accessor :attachments

  def attachment()    @attachments[0]; end
  def attachments?()  @attachments && @attachments.size > 0;  end
  alias :attachment? :attachments?

  alias :enclosures  :attachments
  alias :enclosure   :attachment
  alias :enclosures? :attachments?
  alias :enclosure?  :attachments?


  def initialize
    ## note: make authors, tags empty arrays on startup (e.g. not nil)
    @authors     = []
    @tags        = []
    @attachments = []
  end

end  # class Item

end # module FeedParser
