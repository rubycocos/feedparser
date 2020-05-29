###
#  to run use
#     ruby -I ./lib -I ./test test/test_attachments_live.rb
#  or better
#     rake test

require 'helper'


###
## note: needs to require oga gem (it's not required by default - it's a "soft" dependency)

require 'oga'



class TestAttachmentsLive < MiniTest::Test

  def test_atom_enclose
    feed = fetch_and_parse_feed( 'http://www.lse.ac.uk/assets/richmedia/webFeeds/publicLecturesAndEvents_AtomAllMediaTypesLatest100.xml' )

    assert_equal 'audio/mpeg', feed.items.first.attachment.type
    assert_equal 'audio/mpeg', feed.items.first.enclosure.type

    assert_equal true, feed.items.first.attachment?
    assert_equal true, feed.items.first.enclosure?
  end

  def test_atom_media
    feed = fetch_and_parse_feed( 'http://www.youtube.com/feeds/videos.xml?channel_id=UCZUT79WUUpZlZ-XMF7l4CFg' )
    assert_equal true, feed.items.first.attachment?
    assert feed.items.first.attachments.first.title
    assert feed.items.first.attachments.first.url
    assert feed.items.first.attachments.first.thumbnail
    assert_instance_of FeedParser::Thumbnail, feed.items.first.attachments.first.thumbnail
    assert feed.items.first.attachments.first.thumbnail.url
    assert_equal 480, feed.items.first.attachments.first.thumbnail.width.to_i
    assert_equal 360, feed.items.first.attachments.first.thumbnail.height.to_i
    assert feed.items.first.attachments.first.description
  end

  def test_rss_media
    # tests an example RSS file from https://creator.amazon.com/documentation/ac/mrss.html. Not that unlike the Atom example, it does
    # does not put everything under media:group
    testpath = File.join(File.expand_path(File.dirname(__FILE__)), 'media_rss_example.txt')
    feed_rss = File.read( testpath )
    feed = FeedParser::Parser.parse( feed_rss )
    assert_equal true, feed.items.first.attachment?
    assert feed.items.first.attachments.first.title
    assert feed.items.first.attachments.first.url
    assert feed.items.first.attachments.first.thumbnail
    assert_instance_of FeedParser::Thumbnail, feed.items.first.attachments.first.thumbnail
    assert feed.items.first.attachments.first.thumbnail.url
    assert_nil feed.items.first.attachments.first.thumbnail.width
    assert_nil feed.items.first.attachments.first.thumbnail.height
    assert feed.items.first.attachments.first.description
  end

  def test_rss_enclosure
    feed = fetch_and_parse_feed( 'http://www.radiofreesatan.com/category/featured/feed/' )

    assert_equal 'audio/mpeg', feed.items.first.attachment.type
    assert_equal 'audio/mpeg', feed.items.first.enclosure.type

    assert_equal true, feed.items.first.attachment?
    assert_equal true, feed.items.first.enclosure?
  end

end
