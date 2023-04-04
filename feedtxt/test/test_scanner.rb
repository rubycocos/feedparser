###
#  to run use
#     ruby -I ./lib -I ./test test/test_scanner.rb
#  or better
#     rake test

require 'helper'


class TestScanner < MiniTest::Test

  ## note:
  ##   regex excape  pipe: | to \|
  ##   note: \\ needs to get escaped twice e.g. (\\ becomes \)
  FEED_BEGIN = %{^[ ]*\\|>>>+[ ]*$}
  FEED_END   = %{^[ ]*<<<+\\|[ ]*$}

  def test_scan

text =<<TXT
bla bla bla
|>>>
title:          "My Example Feed"
home_page_url:  "https://example.org/"
feed_url:       "https://example.org/feed.txt"
</>
id:  "2"
url: "https://example.org/second-item"
---
This is a second item.
</>
id:  "1"
url: "https://example.org/initial-post"
---
Hello, world!
<<<|
TXT

    s = StringScanner.new( text )

    prolog = s.scan_until( /(?=#{FEED_BEGIN})/ )
    pp prolog

    feed_begin = s.scan( /#{FEED_BEGIN}/ )
    assert_equal '|>>>', feed_begin

    body =  s.scan_until( /(?=#{FEED_END})/ )
    pp body

    feed_end = s.scan( /#{FEED_END}/ )
    assert_equal '<<<|', feed_end

    assert true
  end

end # class TestScanner
