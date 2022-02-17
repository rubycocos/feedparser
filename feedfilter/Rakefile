require 'hoe'
require './lib/feedfilter/version.rb'

Hoe.spec 'feedfilter' do

  self.version = FeedFilter::VERSION

  self.summary = "feedfilter - feed filter and rules for easy (re)use"
  self.description = summary

  self.urls    = ['https://github.com/feedreader/feed.filter']

  self.author  = 'Gerald Bauer'
  self.email   = 'feedreader@googlegroups.com'

  # switch extension to .markdown for gihub formatting
  self.readme_file  = 'README.md'
  self.history_file = 'HISTORY.md'

  self.extra_deps = [
    ['textutils', '>=1.0.1'],
  ]

  self.licenses = ['Public Domain']

  self.spec_extras = {
    required_ruby_version: '>= 1.9.2'
  }

end
