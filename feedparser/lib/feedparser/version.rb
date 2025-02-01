# encoding: utf-8

module FeedParser

  MAJOR = 2
  MINOR = 2
  PATCH = 1
  VERSION = [MAJOR,MINOR,PATCH].join('.')

  def self.version
    VERSION
  end


  def self.banner
    "feedparser/#{VERSION} (with rss/#{RSS::VERSION} n json/#{JSON::VERSION}) on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
  end

  def self.root
    "#{File.expand_path( File.dirname(File.dirname(File.dirname(__FILE__))) )}"
  end

end # module FeedParser
