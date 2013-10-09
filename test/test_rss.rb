###
#  to run use
#     ruby -I ./lib -I ./test test/test_rss.rb
#  or better
#     rake test

require 'helper'

class TestRss < MiniTest::Unit::TestCase


  def test_rubyflow
    feed = parse_feed( 'http://feeds.feedburner.com/Rubyflow?format=xml' )
    
    assert_equal 'rss 2.0', feed.format
  end

  def test_sitepointruby
    feed = parse_feed( 'http://www.sitepoint.com/ruby/feed/' )

    assert_equal 'rss 2.0', feed.format
  end

  def test_lambdatheultimate
    ## check - has no item.guid - will use item.link for guid
    feed = parse_feed( 'http://lambda-the-ultimate.org/rss.xml' )

    assert_equal 'rss 2.0', feed.format
  end

  def test_rubymine
    # includes item/content:encoded
    feed = parse_feed( 'http://feeds.feedburner.com/jetbrains_rubymine?format=xml' )
    
    assert_equal 'rss 2.0', feed.format
  end

end
