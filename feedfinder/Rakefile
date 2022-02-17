require 'hoe'
require './lib/feedfinder/version.rb'

Hoe.spec 'feedfinder' do

  self.version = FeedFinder::VERSION

  self.summary = "feedfinder - web feed finder and discovery (RSS, Atom, JSON Feed, etc.)"
  self.description = summary

  self.urls    = ['https://github.com/feedparser/feedfinder']

  self.author  = 'Gerald Bauer'
  self.email   = 'wwwmake@googlegroups.com'

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
