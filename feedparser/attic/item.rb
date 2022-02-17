module FeedParser

class Item

  ## attr_accessor :object   # not used for now -- orginal object (e.g RSS item or ATOM entry etc.)

  attr_accessor :title_type    # optional for now (text|html|html-escaped) - not yet set

  attr_accessor   :summary_type  # optional for now (text|html|html-escaped) - not yet set

  attr_accessor :url      # todo: rename to link (use alias) ??

## todo: add summary (alias description)  ???


end  # class Item

end # module FeedParser

