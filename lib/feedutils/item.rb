module FeedUtils

class Item
  ## attr_accessor :object   # not used for now -- orginal object (e.g RSS item or ATOM entry etc.)

  attr_accessor :title
  attr_accessor :title_type    # optional for now (text|html|html-escaped) - not yet set
  attr_accessor :url      # todo: rename to link (use alias) ??


  def content?()  @content.nil? == false;  end
  attr_accessor  :content
  attr_accessor  :content_type  # optional for now (text|html|html-escaped|binary-base64) - not yet set

  def summary?()  @summary.nil? == false;  end
  attr_accessor   :summary
  attr_accessor   :summary_type  # optional for now (text|html|html-escaped) - not yet set

## todo: add summary (alias description)  ???
## todo: add author/authors
## todo: add category/categories

  def published?()  @published.nil? == false;  end
  attr_accessor :published

  def updated?()  @updated.nil? == false;  end
  attr_accessor :updated

  attr_accessor :guid     # todo: rename to id (use alias) ??


end  # class Item

end # module FeedUtils
