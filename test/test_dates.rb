###
#  to run use
#     ruby -I ./lib -I ./test test/test_dates.rb
#  or better
#     rake test

require 'helper'


class TestDates < MiniTest::Test

  def test_iso8601

    recs = [
      [ '2017-05-20T19:23:06Z',       DateTime.new(2017, 5,20,19,23, 6) ],       # from daringfireball.json
      [ '2017-05-20T19:23:08Z',       DateTime.new(2017, 5,20,19,23, 8) ],
      [ '2017-05-17T08:02:12-07:00',  DateTime.new(2017, 5,17, 8, 2,12,'-7') ],  # from jsonfeed.json
      [ '2017-05-18T21:08:49+00:00',  DateTime.new(2017, 5,18,21, 8,49) ],       # from byparker.json
    ]

    recs.each do |rec|
      d = DateTime.iso8601( rec[0] )
      puts "class: #{d.class.name} - #{d.utc}"
      pp d
      assert_equal rec[1], d
    end
  end   # test_iso8601


end # class TestDates
