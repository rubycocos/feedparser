# encoding: utf-8

module FeedUtils

  MAJOR = 0
  MINOR = 5
  PATCH = 0
  VERSION = [MAJOR,MINOR,PATCH].join('.')

  def self.version
    VERSION
  end


  def self.banner
    "feedutils/#{VERSION} (with stdlib rss/#{RSS::VERSION}) on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
  end

  def self.root
    "#{File.expand_path( File.dirname(File.dirname(File.dirname(__FILE__))) )}"
  end  

end # module FeedUtils

