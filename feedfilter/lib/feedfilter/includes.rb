# encoding: utf-8


module FeedFilter


class IncludeFilters

  include LogUtils::Logging

  def initialize( includes )
    @includes = includes

    ## split terms (allow comma,pipe) - do NOT use space; allows e.g. terms such as github pages
    @terms = includes.split( /\s*[,|]\s*/ )
    ## remove leading and trailing white spaces - check - still required when using \s* ??
    @terms = @terms.map { |term| term.strip }
  end


  def match_item?( item )
    match_terms?( item.title   ) ||
    match_terms?( item.summary ) ||
    match_terms?( item.content )
  end

private

  def match_terms?( text )   ### make helper method private - why? why not??
    return false  if text.nil? || text.empty?     ## allow/guard against nil and empty string (use blank?)

    @terms.each do |term|
      if /#{term}/i =~ text      ## Note: lets ignore case (use i regex option) 
        return true
      end
    end

    false  # no term match found
  end

end # class IncludeFilters

end # module FeedFilter
