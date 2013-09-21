###
#  to run use
#     ruby -I ./lib -I ./test test/test_rss.rb
#  or better
#     rake test

require 'helper'

class TestAtom < MiniTest::Unit::TestCase

  def test_rubyonrails
    feed = parse_feed( 'http://weblog.rubyonrails.org/feed/atom.xml' )
    assert( feed.format == 'atom' )
  end

end
