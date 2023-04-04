# encoding: utf-8

module Feedtxt


class Parser

  include LogUtils::Logging


  ### convenience class/factory method
  def self.parse( text, opts={} )
    self.new( text ).parse
  end

  ### Note: lets keep/use same API as RSS::Parser for now
  def initialize( text )
    @text = text
  end


  def parse
    ## auto-detect format
    ##   use "best" matching format (e.g. first match by pos(ition))

    klass = YAML           ## default to yamlparser for now
    pos   = 9_999_999     ## todo:use  MAX INTEGER or something!!

    json = @text.index( /#{JSON::FEED_BEGIN}/ )
    if json    # found e.g. not nil? incl. 0
      pos   = json
      klass = JSON
    end

    ini = @text.index( /#{INI::FEED_BEGIN}/ )
    if ini && ini < pos  # found e.g. not nil? and match before last?
      pos   = ini
      klass = INI
    end

    yaml = @text.index( /#{YAML::FEED_BEGIN}/ )
    if yaml && yaml < pos  # found e.g. not nil? and match before last?
      pos   = yaml
      klass = YAML
    end

    feed = klass.parse( @text )
    feed
  end # method parse

end  # class Parser

end # module Feedtxt
