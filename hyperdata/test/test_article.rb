###
#  to run use
#     ruby -I ./lib -I ./test test/test_article.rb
#  or better
#     rake test

require 'helper'


class TestArticle < MiniTest::Test

  def test_article
    text = read_text( 'spec/article' )
    ## text = read_text( 'spec/o/item' )
    feed = Hyperdata::Parser.parse( text )
    pp feed

    assert true
  end

end # class TestArticle
