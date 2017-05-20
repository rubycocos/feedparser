###
#  to run use
#     ruby -I ./lib -I ./test test/test_atom_live.rb
#  or better
#     rake test

require 'helper'

class TestAtomLive < MiniTest::Test

  def test_rubyonrails
    feed = fetch_and_parse_feed( 'http://weblog.rubyonrails.org/feed/atom.xml' )

    assert_equal 'atom',                           feed.format
    assert_equal 'http://weblog.rubyonrails.org/', feed.url
  end


  def test_railstutorial
    feed = fetch_and_parse_feed( 'http://feeds.feedburner.com/railstutorial?format=xml' )

    assert_equal 'atom',                           feed.format
    assert_equal 'http://news.learnenough.com/',   feed.url
    ## note was (2017/5):  assert_equal 'http://news.railstutorial.org/', feed.url
  end


  def test_googlegroup
    feed = fetch_and_parse_feed( 'https://groups.google.com/forum/feed/beerdb/topics/atom.xml?num=15' )

    assert_equal 'atom', feed.format
    assert_equal 'https://groups.google.com/d/forum/beerdb', feed.url
  end


  def test_headius
    feed = fetch_and_parse_feed( 'http://blog.headius.com/feeds/posts/default' )

    assert_equal 'atom',    feed.format
    assert_equal 'Blogger', feed.generator
    assert_equal 'Headius', feed.title
    assert_equal 'Helping the JVM Into the 21st Century', feed.summary  # aka subtitle in atom
    assert_equal 'http://blog.headius.com/', feed.url
  end

end
