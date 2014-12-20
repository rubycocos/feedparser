###
#  to run use
#     ruby -I ./lib -I ./test test/test_atom_from_file.rb
#  or better
#     rake test

require 'helper'


class TestAtomFromFile < MiniTest::Test

  def test_googlegroup
    feed = parse_feed_from_file( 'googlegroups.atom' )

    assert_equal 'atom', feed.format
    assert_equal 'Google Groups', feed.generator
    assert_equal 'https://groups.google.com/d/forum/beerdb', feed.url
  end

  def test_googlegroup2
    feed = parse_feed_from_file( 'googlegroups2.atom' )

    assert_equal 'atom', feed.format
    assert_equal 'Google Groups (w/ leading n trailing newlines stripped)', feed.generator
    assert_equal 'https://groups.google.com/d/forum/beerdb', feed.url
  end

end # class TestAtomFromFile
