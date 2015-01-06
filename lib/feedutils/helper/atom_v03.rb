# encoding: utf-8


###
# hack:
##  try to patch/convert old obsolete atom v0.3 to v1(-ish)
##
##  in <feed> convert
##   version="0.3"                     =>  removed/dropped! - use ns for version
##   xmlns="http://purl.org/atom/ns#"  => xmlns="http://www.w3.org/2005/Atom"
##
##  <modified>2014-12-31T15:33:00Z</modified>  => <updated>
##  <issued>2014-12-31T13:02:07Z</issued>  => <published>
##
##
## more changes:
##   author url   => author uri
##   generator @url => generator @uri
##   tagline    => subtitle
##   copyright  => rights
##  <created>2014-12-31T13:02:07Z</created>  =>  removed/dropped!
##
##  todo/fix:  fix/convert content @type @mode - why?? why not??
##
##  content @mode => removed/dropped!
##  @type=text/plain @mode=escaped     => @type=text
##  @type=text/html  @mode=escaped     => @type=html


## see also
##  - rakaz.nl/2005/07/moving-from-atom-03-to-10.html


module FeedUtils

class AtomV03Helper

  include LogUtils::Logging

  def match?( xml )
    ## Note: =~ return nil on match; convert to boolean e.g. always return true|false
    (xml =~ /<feed\s+version="0\.3"/) != nil
  end

  def convert( xml )
    xml = xml.sub( /<feed[^>]+>/ ) do |m|
      ## Note: m passed in is just a string w/ the match (NOT a match data object!)
      ## puts "match (#{m.class.name}): "
      ## pp m
      el = m.sub( /version="0\.3"/, '' )
      el = el.sub( /xmlns="http:\/\/purl\.org\/atom\/ns#"/, 'xmlns="http://www.w3.org/2005/Atom"' )
      el
    end

    xml = xml.gsub( /<modified>/, '<updated>' )
    xml = xml.gsub( /<\/modified>/, '</updated>' )

    xml = xml.gsub( /<issued>/, '<published>' )
    xml = xml.gsub( /<\/issued>/, '</published>' )
    xml
  end

end # class AtomV03Helper

end # module FeedUtils

