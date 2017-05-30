###
#  to run use
#     ruby -I ./lib -I ./test test/test_authors.rb
#  or better
#     rake test

require 'helper'


class TestAuthors < MiniTest::Test

  def test_all
    names = [
             'spec/atom/author.atom',
             'spec/atom/authors.atom',
             'spec/rss/creator.rss',
            ]

    names.each do |name|
      assert_feed_tests_for( name )
    end
  end


end # class TestAuthors
