###
#  to run use
#     ruby -I ./lib -I ./test test/test_rss.rb
#  or better
#     rake test

require 'helper'

class TestAtom < MiniTest::Test

  def test_rubyonrails
    feed = parse_feed( 'http://weblog.rubyonrails.org/feed/atom.xml' )
    
    assert_equal 'atom', feed.format
  end

  def test_railstutorial
    feed = parse_feed( 'http://feeds.feedburner.com/railstutorial?format=xml' )
    
    assert_equal 'atom', feed.format
  end

  def test_googlegroup
    feed = parse_feed( 'https://groups.google.com/forum/feed/beerdb/topics/atom.xml?num=15' )

    assert_equal 'atom', feed.format
  end


  def test_headius
    feed = parse_feed( 'http://blog.headius.com/feeds/posts/default' )

    assert_equal 'atom',    feed.format
    assert_equal 'Blogger', feed.generator
    assert_equal 'Headius', feed.title
    assert_equal 'Helping the JVM Into the 21st Century', feed.title2  # aka subtitle in atom
  end

end
