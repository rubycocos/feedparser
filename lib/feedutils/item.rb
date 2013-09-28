module FeedUtils

class Item
  attr_accessor :object   # orginal object (e.g RSS item or ATOM entry etc.)

  attr_accessor :title
  attr_accessor :title_type    # optional for now (text|html|html-escaped) - not yet set
  attr_accessor :url      # todo: rename to link (use alias) ??


  # no content? try/return summary
  def content()  content? ? @content : @summary;  end
  def content?()  @content.nil? == false;  end
  attr_writer   :content

  attr_accessor :content_type  # optional for now (text|html|html-escaped|binary-base64) - not yet set

  # no summary? try/return content
  def summary()  summary? ? @summary : @content;  end
  def summary?()  @summary.nil? == false;  end
  attr_writer   :summary

  attr_accessor :summary_type  # optional for now (text|html|html-escaped) - not yet set

## todo: add summary (alias description)  ???
## todo: add author/authors
## todo: add category/categories

  # no published date? try/return updated
  def published()  published? ? @published : @updated;  end
  def published?()  @published.nil? == false;  end
  attr_writer :published

  def updated?()  @updated.nil? == false;  end
  attr_accessor :updated

  attr_accessor :guid     # todo: rename to id (use alias) ??


end  # class Item

end # module FeedUtils
