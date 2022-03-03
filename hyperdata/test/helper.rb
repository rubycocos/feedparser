## $:.unshift(File.dirname(__FILE__))


## minitest setup

require 'minitest/autorun'

require 'logutils'
require 'textutils'


## our own code
require 'hyperdata'



LogUtils::Logger.root.level = :debug


def read_text( name )
  text = File.read( "#{Hyperdata.root}/test/feeds/#{name}.html" )
  text
end
