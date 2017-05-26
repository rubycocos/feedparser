###
#  to run use
#     ruby -I ./lib -I ./test test/test_feeds.rb
#  or better
#     rake test

require 'helper'


class TestFeeds < MiniTest::Test

  def test_all
    names = [
             'learnenough.atom',
             'xkcd.atom',
             'xkcd.rss2',
             'daringfireball.atom',
             'intertwingly.atom',
             'ongoing.atom',
             'scripting.rss2',
            ]

    names.each do |name|
      assert_feed_tests_for( name )
    end
  end


end # class TestFeeds
