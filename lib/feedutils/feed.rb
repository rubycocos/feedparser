module FeedUtils

class Feed
  attr_accessor :object

  attr_accessor :format   # e.g. atom|rss 2.0|etc.
  attr_accessor :title
  attr_accessor :title_type  # e.g. text|html|html-escaped  (optional) -use - why?? why not??
  attr_accessor :url

  attr_accessor :items

  def summary?()  @summary.nil? == false;  end
  # no summary? try/return title2
  def summary()  summary?  ?  @summary : @title2;  end
  attr_writer :summary        # e.g. description (rss)

  attr_accessor :summary_type   # e.g. text|html|html-escaped

  def title2?()  @title2.nil? == false;  end
  attr_accessor :title2         # e.g. subtitle (atom)

  attr_accessor :title2_type    # e.g. text|html|html-escaped

  def published?()  @published.nil? == false;  end
  # no published date? try/return updated or built
  def published
    if published?
      @published
    elsif updated?
      @updated
    else
      @built
    end
  end
  attr_writer :published

  def updated?()  @updated.nil? == false;  end
  attr_accessor :updated

  def built?()  @built.nil? == false;  end
  attr_accessor :built

  attr_accessor :generator


  ## fix:
  #  add pretty printer/inspect (exclude object)

end  # class Feed

end # module FeedUtils
