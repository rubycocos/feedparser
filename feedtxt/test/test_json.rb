###
#  to run use
#     ruby -I ./lib -I ./test test/test_json.rb
#  or better
#     rake test

require 'helper'


class TestJson < MiniTest::Test

  def test_example

    text = read_text( 'spec/example.json' )
    pp text

    exp = [
      {"title"=>"My Example Feed",
  "home_page_url"=>"https://example.org/",
  "feed_url"=>"https://example.org/feed.txt"},
    [[
      {"id"=>"2", "url"=>"https://example.org/second-item"},
       "This is a second item."
     ],
     [
       {"id"=>"1", "url"=>"https://example.org/initial-post"},
       "Hello, world!"
    ]]]

    assert_equal exp, Feedtxt::JSON.parse( text )
    assert_equal exp, Feedtxt.parse( text )     ## try shortcut alias too
  end

  def test_podcast

    text = read_text( 'spec/podcast.json' )
    pp text

    exp =[{"comment"=>
   "This is a podcast feed. You can add this feed to your podcast client using the following URL: http://therecord.co/feed.json",
  "title"=>"The Record",
  "home_page_url"=>"http://therecord.co/",
  "feed_url"=>"http://therecord.co/feed.txt"},
 [[{"id"=>"http://therecord.co/chris-parrish",
    "title"=>"Special #1 - Chris Parrish",
    "url"=>"http://therecord.co/chris-parrish",
    "summary"=>
     "Brent interviews Chris Parrish, co-host of The Record and one-half of Aged & Distilled.",
    "published"=> "2014-05-09T14:04:00-07:00",
    "attachments"=>
     [{"url"=>
        "http://therecord.co/downloads/The-Record-sp1e1-ChrisParrish.m4a",
       "mime_type"=>"audio/x-m4a",
       "size_in_bytes"=>89970236,
       "duration_in_seconds"=>6629}]},
   "Chris has worked at [Adobe][1] and as a founder of Rogue Sheep, which won an Apple Design Award for Postage.\nChris's new company is Aged & Distilled with Guy English - which shipped [Napkin](2),\na Mac app for visual collaboration. Chris is also the co-host of The Record.\nHe lives on [Bainbridge Island][3], a quick ferry ride from Seattle.\n\n[1]: http://adobe.com/\n[2]: http://aged-and-distilled.com/napkin/\n[3]: http://www.ci.bainbridge-isl.wa.us/"]]]

    assert_equal exp, Feedtxt::JSON.parse( text )
    assert_equal exp, Feedtxt.parse( text )   ## try shortcut alias too
  end


end # class TestYaml
