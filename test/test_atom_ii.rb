###
#  to run use
#     ruby -I ./lib -I ./test test/test_atom_ii.rb
#  or better
#     rake test

require 'helper'


class TestAtomV2 < MiniTest::Test

  def test_all
    names = [
             'learnenough.atom',
             'xkcd.atom',
             'daringfireball.atom',
            ]

    names.each do |name|
      assert_feed_tests_for( name )
    end
  end


end # class TestAtomV2
