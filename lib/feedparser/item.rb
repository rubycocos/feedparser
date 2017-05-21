# encoding: utf-8

module FeedParser

class Item

  attr_accessor :title
  attr_accessor :url

  def content?()  @content.nil? == false;  end
  attr_accessor  :content    # todo: make it for now an alias for content_html

  ## todo: remove content_type  use content_html and content_text
  attr_accessor  :content_type  # optional for now (text|html|html-escaped|binary-base64) - not yet set


  def summary?()  @summary.nil? == false;  end
  attr_accessor   :summary


  def updated?()  @updated.nil? == false;  end
  attr_accessor :updated   # pubDate (RSS)|updated (Atom)

  def published?()  @published.nil? == false;  end
  attr_accessor :published  # note: published is basically an alias for created

  attr_accessor :guid     # todo: rename to id (use alias) ??

## todo: add author/authors
## todo: add category/categories

end  # class Item

end # module FeedParser
