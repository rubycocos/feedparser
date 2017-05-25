###
#  to run use
#     ruby -I ./lib -I ./test test/test_dates.rb
#  or better
#     rake test

require 'helper'


class TestDates < MiniTest::Test

  def test_iso8601   # used by atom, json feed

    recs = [
      [ '2017-05-20T19:23:06Z',       DateTime.new(2017, 5,20,19,23, 6) ],       # from daringfireball.json
      [ '2017-05-20T19:23:08Z',       DateTime.new(2017, 5,20,19,23, 8) ],
      [ '2017-05-17T08:02:12-07:00',  DateTime.new(2017, 5,17, 8, 2,12,'-7') ],  # from jsonfeed.json
      [ '2017-05-18T21:08:49+00:00',  DateTime.new(2017, 5,18,21, 8,49) ],       # from byparker.json
      [ '2017-05-18T21:08:49.123+00:00', DateTime.new(2017, 5,18,21, 8,49.123) ],   ### try with usec e.g. 49.124
      [ '2017-05-17T08:02:12.567-07:00', DateTime.new(2017, 5,17, 8, 2,12.567,'-7') ],
    ]

    recs.each do |rec|
      d = DateTime.iso8601( rec[0] )
      puts "class: #{d.class.name} - #{d.utc} (#{d.usec}) <= iso8601 #{rec[0]}"
      pp d
      assert_equal rec[1], d
    end
  end   # test_iso8601


  def test_rfc822   # used by rss 2.0

    recs = [
      [ 'Sat, 17 Jan 2015 11:57:47 +0000', DateTime.new( 2015, 1,17,11,57,47) ],  # from sitepoint.rss2
      [ 'Thu, 15 Jan 2015 15:00:56 +0000', DateTime.new( 2015, 1,15,15,00,56) ],
      [ 'Fri, 16 Jan 2015 17:33:47 +0100', DateTime.new( 2015, 1,16,17,33,47,'+1') ],  # from rubyflow.rss2
      [ 'Fri, 16 Jan 2015 09:33:57 +0100', DateTime.new( 2015, 1,16, 9,33,57,'+1') ],
	    [ 'Wed, 17 Dec 2014 12:30:48 +0000', DateTime.new( 2014,12,17,12,30,48) ],  # from rubymine.rss2
    ]

    recs.each do |rec|
      d = DateTime.rfc822( rec[0] )
      puts "class: #{d.class.name} - #{d.utc} (#{d.usec}) <= rfc822 #{rec[0]}"
      pp d
      assert_equal rec[1], d
    end

  end  # test_rfc822


end # class TestDates
