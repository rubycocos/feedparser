module FeedUtils

class Feed
  ### attr_accessor :object  # not use for now

  attr_accessor :format   # e.g. atom|rss 2.0|etc.
  attr_accessor :title
  attr_accessor :title_type  # e.g. text|html|html-escaped  (optional) -use - why?? why not??
  attr_accessor :url

  attr_accessor :items

  def summary?()  @summary.nil? == false;  end
  attr_accessor :summary        # e.g. description (rss)
  attr_accessor :summary_type   # e.g. text|html|html-escaped

  def title2?()  @title2.nil? == false;  end
  attr_accessor :title2         # e.g. subtitle (atom)
  attr_accessor :title2_type    # e.g. text|html|html-escaped

  def published?()  @published.nil? == false;  end
  attr_accessor :published

  def updated?()  @updated.nil? == false;  end
  attr_accessor :updated

  def built?()  @built.nil? == false;  end
  attr_accessor :built

  attr_accessor :generator
  attr_accessor :generator_version  # e.g. @version (atom)
  attr_accessor :generator_uri      # e.g. @uri     (atom) - use alias url/link ???

  ## fix:
  #  add pretty printer/inspect (exclude object)


end  # class Feed

end # module FeedUtils
