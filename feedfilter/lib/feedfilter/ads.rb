# encoding: utf-8


module FeedFilter


class AdsFilters

  include LogUtils::Logging

  def initialize
    @filters=[]

    names=[
      'feedburner',
      'feedflare'
    ]

    names.each do |name|
      logger.debug "  add ads filter #{name}"

      b = BlockReader.from_file( "#{FeedFilter.root}/config/#{name}.txt").read
      ## Note: replace newline and space in string for regex (w/o spaces)
      ## Note: add multiline option and ignore case
      regexp = Regexp.new( b[0].gsub( /[\n ]/, '' ), Regexp::MULTILINE|Regexp::IGNORECASE )
      @filters << [name, regexp]
    end
  end

  def filter( text )
    @filters.each do |f|
      name     = f[0]
      pattern  = f[1]
      
      text = text.gsub( pattern ) do |m|
        # Note: m - match is just a regular string
        ##  double check if it's true also if regex contains capture groups ???
        puts "strip #{name}:"
        pp m
        ''
      end
    end # each filter
    text
  end  # filter

end # AdsFilters


  def self.strip_ads( text )  
    @@ads_filters ||= FeedFilter::AdsFilters.new
    @@ads_filters.filter( text )
  end


  module AdsFilter
    def strip_ads( text )
      FeedFilter.strip_ads( text )
    end
  end # module AdsFilter

end # module FeedFilter

