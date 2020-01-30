###
#  to run use
#     ruby -I ./lib -I ./test test/test_atom_live.rb
#  or better
#     rake test



require 'helper'

class TestAtomLive < MiniTest::Test

  def test_rubyonrails
    feed = fetch_and_parse_feed( 'http://weblog.rubyonrails.org/feed/atom.xml' )

    assert_equal 'atom',                            feed.format
    assert_equal 'https://weblog.rubyonrails.org/', feed.url
    ## note was (2020/1): 'http://weblog.rubyonrails.org/', feed.url
  end


  def test_railstutorial
    feed = fetch_and_parse_feed( 'http://feeds.feedburner.com/railstutorial?format=xml' )

    assert_equal 'atom',                            feed.format
    assert_equal 'https://news.learnenough.com/',   feed.url
    ## note was (2020/1):  assert_equal 'http://news.learnenough.com/',   feed.url
    ## note was (2017/5):  assert_equal 'http://news.railstutorial.org/', feed.url
  end


=begin
  ### returns ssl error e.g.
  ## OpenSSL::SSL::SSLError: SSL_connect SYSCALL returned=5 errno=0 state=SSLv2/v3 read server
  def test_googlegroup
    feed = fetch_and_parse_feed( 'https://groups.google.com/forum/feed/beerdb/topics/atom.xml?num=15' )

    assert_equal 'atom', feed.format
    assert_equal 'https://groups.google.com/d/forum/beerdb', feed.url
  end
=end


  def test_headius
    feed = fetch_and_parse_feed( 'http://blog.headius.com/feed.xml' )
    ## note was (2020/1): 'http://blog.headius.com/feeds/posts/default'

    assert_equal 'atom',    feed.format
    assert_equal 'Jekyll',  feed.generator.name
    ## note was (2020/1): 'Blogger'
    
    assert_equal 'Charles Oliver Nutter', feed.title
    ## note was (2020/1): 'Headius', feed.title
    assert_equal 'Java, Ruby, and JVM guy trying to make sense of it all', feed.summary  # aka subtitle in atom
    ## note was (2020/1): 'Helping the JVM Into the 21st Century', feed.title
    assert_equal 'https://headius.github.io/', feed.url
    ## note was (2020/1): 'http://blog.headius.com/' 
  end

end
