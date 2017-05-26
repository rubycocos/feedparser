# encoding: utf-8

module FeedParser

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
  attr_accessor :updated   # pubDate (RSS)|updated (Atom)

  def published?()  @published.nil? == false;  end
  attr_accessor :published  # note: published is basically an alias for created


  attr_accessor :id

  ## note: guid is an alias for id
  alias :guid  :id
  alias :guid= :id=


## todo: add author/authors
## todo: add category/categories

end  # class Item

end # module FeedParser
