module FeedParser

class Feed
  ### attr_accessor :object  # not use for now

  attr_accessor :title_type  # e.g. text|html|html-escaped  (optional) -use - why?? why not??
  attr_accessor :summary_type   # e.g. text|html|html-escaped

  def title2?()  @title2.nil? == false;  end
  attr_accessor :title2         # e.g. subtitle (atom)
  attr_accessor :title2_type    # e.g. text|html|html-escaped

  def built?()  @built.nil? == false;  end
  attr_accessor :built



  attr_accessor :generator_version  # e.g. @version (atom)
  attr_accessor :generator_url      # e.g. @uri     (atom)

  ## note: generator_uri is an alias for generator_url
  alias :generator_uri  :generator_url
  alias :generator_uri= :generator_url=




end  # class Feed

end # module FeedParser
