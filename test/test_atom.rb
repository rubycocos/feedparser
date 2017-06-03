###
#  to run use
#     ruby -I ./lib -I ./test test/test_atom.rb
#  or better
#     rake test

require 'helper'


class TestAtom < MiniTest::Test

  def test_all
    names = [
             'googlegroups.atom',
             'googlegroups2.atom',
             'rubyonrails.atom',
             'railstutorial.feedburner.atom',
             'headius.atom',
            ]

    names.each do |name|
      assert_feed_tests_for( name )
    end
  end


end # class TestAtom
