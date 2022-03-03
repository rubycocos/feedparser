###
#  to run use
#     ruby -I ./lib -I ./test test/test_version.rb
#  or better
#     rake test

require 'helper'


class TestVersion < MiniTest::Test

  def test_version

    puts "Hyperdata: #{Hyperdata::VERSION}"

    assert true
  end

end # class TestVersion
