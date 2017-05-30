###
#  to run use
#     ruby -I ./lib -I ./test test/test_tags.rb
#  or better
#     rake test

require 'helper'


class TestTags < MiniTest::Test

  def test_all
    names = [
             'spec/atom/categories.atom',
             'spec/rss/categories.rss',
            ]

    names.each do |name|
      assert_feed_tests_for( name )
    end
  end


end # class TestTags
