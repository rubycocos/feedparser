# encoding: utf-8

module FeedParser

class Author

  attr_accessor :name
  attr_accessor :url
  ## note: uri is an alias for url
  alias :uri  :url       ## add atom alias for uri - why? why not?
  alias :uri= :url=

  def email?()   @email.nil? == false;  end
  attr_accessor :email

  def avatar?()  @avatar.nil? == false;  end
  attr_accessor :avatar  # todo/check: use avatar_url ?? used by json feed -check if always a url

end  # class Author

end # module FeedParser
