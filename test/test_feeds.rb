###
#  to run use
#     ruby -I ./lib -I ./test test/test_feeds.rb
#  or better
#     rake test

require 'helper'


class TestFeeds < MiniTest::Test

  def test_all
    names = [
             'learnenough.feedburner.atom',
             'xkcd.atom',
             'xkcd.rss',
             'daringfireball.atom',
             'intertwingly.atom',
             'ongoing.atom',
             'scripting.rss',
            ]

    names.each do |name|
      assert_feed_tests_for( name )
    end
  end


end # class TestFeeds
