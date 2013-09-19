

require 'feedutils/version'  # let it always go first


module FeedUtils

  def self.banner
    "feedutils #{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
  end

=begin
  def self.root
    "#{File.expand_path( File.dirname(File.dirname(__FILE__)) )}"
  end
=end

end  # module FeedUtils


puts FeedUtils.banner    # say hello

