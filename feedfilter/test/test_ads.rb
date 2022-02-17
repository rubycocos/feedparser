###
#  to run use
#     ruby -I ./lib -I ./test test/test_ads.rb
#  or better
#     rake test

require 'helper'


class TestAds < MiniTest::Test

  include FeedFilter::AdsFilter


  def test_feedflare_ads
     text =<<EOS
<div class="feedflare">
 <a href="http://feeds.feedburner.com/~ff/Rubyflow?a=1wUDnBztAJY:fzqBvTOGB9M:3H-1DwQop_U">
   <img src="http://feeds.feedburner.com/~ff/Rubyflow?i=1wUDnBztAJY:fzqBvTOGB9M:3H-1DwQop_U" border="0"></img>
 </a>
</div>
EOS
     text = strip_ads( text ).strip

     assert_equal '', text
  end


  def test_feedburner_bugs
     text =<<EOS
<img src="//feeds.feedburner.com/~r/Rubyflow/~4/1wUDnBztAJY" height="1" width="1" alt=""/>
EOS
     text = strip_ads( text ).strip

     assert_equal '', text
  end

end # class TestAds
