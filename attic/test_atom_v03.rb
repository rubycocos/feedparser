

class TestAtomV03 < MiniTest::Test

  def test_match
    xmlv1   = read_feed_from_file( 'googlegroups.atom' )
    xmlv03  = read_feed_from_file( 'quirksblog.atom.v03' )

    atomv03helper = FeedUtils::AtomV03Helper.new

    assert_equal false, atomv03helper.match?( xmlv1 )
    assert_equal true,  atomv03helper.match?( xmlv03 )

    xmlv03up = atomv03helper.convert( xmlv03 )
    assert_equal false, atomv03helper.match?( xmlv03up )

    pp xmlv03up[0..1000]
  end

  def test_parse
    feed  = parse_feed_from_file( 'quirksblog.atom.v03' )

    pp feed.updated
    assert_equal '2014-12-31T15:33:00+00:00', feed.updated.to_s

    pp feed.items[0].updated
    assert_equal '2014-12-31T15:33:00+00:00', feed.items[0].updated.to_s

    pp feed.items[1].updated
    assert_equal '2014-11-26T12:11:25+00:00', feed.items[1].updated.to_s
  end

end
