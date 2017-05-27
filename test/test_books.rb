###
#  to run use
#     ruby -I ./lib -I ./test test/test_books.rb
#  or better
#     rake test

require 'helper'


class TestBooks < MiniTest::Test

  def test_all
    names = [
             'books/nostarch.rss2',
             'books/pragprog.rss2',
             'books/oreilly.atom',
            ]

    names.each do |name|
      assert_feed_tests_for( name )
    end
  end


end # class TestBooks
