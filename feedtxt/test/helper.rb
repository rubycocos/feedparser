## $:.unshift(File.dirname(__FILE__))


## minitest setup

require 'minitest/autorun'

require 'logutils'
require 'textutils'


## our own code
require 'feedtxt'



LogUtils::Logger.root.level = :debug


def read_text( name )
  text = File.read( "#{Feedtxt.root}/test/feeds/#{name}.txt" )
  text
end
