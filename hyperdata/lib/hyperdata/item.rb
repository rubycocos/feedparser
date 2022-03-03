# encoding: utf-8

module Hyperdata

class Item

  attr_accessor :title
  attr_accessor :url


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


  def updated?()  @updated.nil? == false;  end
  attr_accessor :updated
  attr_accessor :updated_local  # "unparsed" local datetime as in feed (NOT converted to utc)

  def published?()  @published.nil? == false;  end
  attr_accessor :published  # note: published is basically an alias for created
  attr_accessor :published_local   # "unparsed" local datetime as in feed (NOT converted to utc)

  attr_accessor :id

end  # class Item

end # module Hyperdata
