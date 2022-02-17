###
#  to run use
#     ruby -I ./lib -I ./test test/test_rss_live.rb
#  or better
#     rake test

require 'helper'

class TestRssLive < MiniTest::Test


  def test_rubyflow
    feed = fetch_and_parse_feed( 'http://feeds.feedburner.com/Rubyflow?format=xml' )

    assert_equal 'rss 2.0', feed.format
  end

  def test_sitepointruby
    feed = fetch_and_parse_feed( 'http://www.sitepoint.com/ruby/feed/' )

    assert_equal 'rss 2.0', feed.format
  end

  def test_lambdatheultimate
    ## check - has no item.guid - will use item.link for guid
    feed = fetch_and_parse_feed( 'http://lambda-the-ultimate.org/rss.xml' )

    assert_equal 'rss 2.0', feed.format
  end

  def test_rubymine
    # includes item/content:encoded
    feed = fetch_and_parse_feed( 'http://feeds.feedburner.com/jetbrains_rubymine?format=xml' )

    assert_equal 'rss 2.0', feed.format
  end

end
