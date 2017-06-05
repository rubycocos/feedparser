###
#  to run use
#     ruby -I ./lib -I ./test test/test_microformats.rb
#  or better
#     rake test


require 'helper'


###
## note: needs to require microformats gem (it's not required by default)

require 'microformats'



class TestMicroformats < MiniTest::Test

  def test_hentry

text =<<HTML
<article class="h-entry">
  <h1 class="p-name">Microformats are amazing</h1>
  <p>Published by
    <a class="p-author h-card" href="http://example.com">W. Developer</a>
     on <time class="dt-published" datetime="2013-06-13 12:00:00">13<sup>th</sup> June 2013</time>

  <p class="p-summary">In which I extoll the virtues of using microformats.</p>

  <div class="e-content">
    <p>Blah blah blah</p>
  </div>
</article>
HTML

    feed = FeedParser::Parser.parse( text )

    assert_equal  'html', feed.format
    assert_equal  1, feed.items.size
    assert_equal  1, feed.items[0].authors.size
    assert_equal  '<p>Blah blah blah</p>', feed.items[0].content_html
    assert_equal  'Blah blah blah', feed.items[0].content_text
    assert_equal  'Microformats are amazing', feed.items[0].title
    assert_equal  'In which I extoll the virtues of using microformats.', feed.items[0].summary
    assert_equal DateTime.new( 2013, 6, 13, 12, 0, 0 ).utc, feed.items[0].published

    assert_equal  'W. Developer', feed.items[0].authors[0].name
  end


end  # class TestMicroformats
