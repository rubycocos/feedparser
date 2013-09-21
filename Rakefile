require 'hoe'
require './lib/feedutils/version.rb'

Hoe.spec 'feedutils' do

  self.version = FeedUtils::VERSION

  self.summary = 'feedutils - web feed parser and normalizer (RSS 2.0, Atom, etc.)'
  self.description = summary

  self.urls    = ['https://github.com/rubylibs/feedutils']

  self.author  = 'Gerald Bauer'
  self.email   = 'webslideshow@googlegroups.com'

  # switch extension to .markdown for gihub formatting
  self.readme_file  = 'README.md'
  self.history_file = 'History.md'

  self.extra_deps = [
    ['logutils', '>= 0.5']
  ]
  
  ###  todo: add fetcher dep for testing (e.g. development only)

  self.licenses = ['Public Domain']

  self.spec_extras = {
   :required_ruby_version => '>= 1.9.2'
  }


end