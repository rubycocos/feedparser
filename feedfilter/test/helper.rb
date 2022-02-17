## $:.unshift(File.dirname(__FILE__))


## minitest setup

require 'minitest/autorun'


## our own code

require 'feedfilter'

LogUtils::Logger.root.level = :debug

