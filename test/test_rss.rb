###
#  to run use
#     ruby -I ./lib -I ./test test/test_rss.rb
#  or better
#     rake test

require 'helper'


class TestRss < MiniTest::Test

  def test_all
    names = [
             'rubyflow.feedburner.rss',
             'sitepoint.rss',
             'lambdatheultimate.rss',
             'rubymine.feedburner.rss',
            ]

    names.each do |name|
      assert_feed_tests_for( name )
    end
  end


end # class TestRss
