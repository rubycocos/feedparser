###
#  to run use
#     ruby -I ./lib -I ./test test/test_atom_from_file.rb
#  or better
#     rake test

require 'helper'


class TestAtomFromFile < MiniTest::Test

  def test_all
    names = ['googlegroups.atom',
             'googlegroups2.atom'
            ]
    
    names.each do |name|
      assert_feed_tests_for( name )
    end
  end


end # class TestAtomFromFile
