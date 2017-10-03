###
#  to run use
#     ruby -I ./lib -I ./test test/test_attachments_live.rb
#  or better
#     rake test

require 'helper'

class TestAttachmentsLive < MiniTest::Test

  def test_atom
    feed = fetch_and_parse_feed( 'http://www.lse.ac.uk/assets/richmedia/webFeeds/publicLecturesAndEvents_AtomAllMediaTypesLatest100.xml' )

    assert_equal 'audio/mpeg', feed.items.first.attachment.type
    assert_equal 'audio/mpeg', feed.items.first.enclosure.type

    assert_equal true, feed.items.first.attachment?
    assert_equal true, feed.items.first.enclosure?
  end


  def test_rss
    feed = fetch_and_parse_feed( 'http://www.radiofreesatan.com/category/featured/feed/' )

    assert_equal 'audio/mpeg', feed.items.first.attachment.type
    assert_equal 'audio/mpeg', feed.items.first.enclosure.type

    assert_equal true, feed.items.first.attachment?
    assert_equal true, feed.items.first.enclosure?
  end

end
