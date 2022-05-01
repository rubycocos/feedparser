# encoding: utf-8

###
#  to run use
#     ruby -I ./test test/test_feeds.rb
#  or better
#     rake test

require  'helper'


class TestFeeds < MiniTest::Test

  def test_all
     walk_feeds( '.' )

     ## parse_feeds( './news/guardian*' )
     ## parse_feeds( './news/nytimes-blogs*' )
  end  # method test_all



private

def walk_feeds( root='.' )
    walk( root ) do |path|

       ## note: skip README, Rakefile etc.
       ##    check for extensions
       extname = File.extname( path )    # note: includes dot e.g. .json etc.
       next unless ['.json', '.html', '.xml', '.rss', '.rss2', '.atom'].include?( extname )

       parse_feed( path )
    end
end # walk_feeds


def parse_feeds( pattern )
  files = Dir.glob( pattern )
  files.each do |path|
      puts "  #{path}"
      parse_feed( path )
  end
end


def parse_feed( path )
       puts "  reading #{path} ..."

       b = BlockReader.from_file( path ).read

       ## puts "  [debug] block.size: #{b.size}"
       text  = b[0]   ## block I: feed source text (xml, json, html, etc.)
       tests = b[1]   ## block II: test assert source

       if tests.nil?
         puts "!!!! test asserts missing in #{path} !!!"
         ## exit 1
       else
         assert_feed( text, tests, name: path )
       end
end

end # class TestFeeds
