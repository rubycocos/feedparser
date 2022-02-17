###
#  to run use
#     ruby -I ./lib -I ./test test/test_ads_all.rb
#  or better
#     rake test

require 'helper'


class TestAdsAll < MiniTest::Test

  def test_all
    names=[
      'feedburner',
      'feedflare'
    ]

    names.each do |name|
      b = BlockReader.from_file( "#{FeedFilter.root}/config/#{name}.txt").read
      ## Note: replace newline and space in string for regex (w/o spaces)
      ## Note: add multiline option and ignore case
      regexp = Regexp.new( b[0].gsub( /[\n ]/, '' ), Regexp::MULTILINE|Regexp::IGNORECASE )
      test1  = b[1]

      assert_equal '', test1.gsub( regexp, '' ).strip
    end
  end

end # class TestAdsAll
