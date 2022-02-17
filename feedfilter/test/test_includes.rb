###
#  to run use
#     ruby -I ./lib -I ./test test/test_includes.rb
#  or better
#     rake test

require 'helper'


TestItem = Struct.new( :title, :summary, :content )

class TestIncludes < MiniTest::Test

  def test_item
    includesFilter = FeedFilter::IncludeFilters.new( 'github pages|jekyll' )

    item1 = TestItem.new
    item1.title   = 'title'
    item1.summary = 'summary'
    item1.content = 'content'

    item2 = TestItem.new
    item2.title   = 'title'
    item2.summary = 'summary'
    item2.content = 'bla bla JEKYLL bla bla'
  
    assert false == includesFilter.match_item?( item1 )
    assert true  == includesFilter.match_item?( item2 )
  end

end # class TestIncludes

