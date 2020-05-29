require 'hoe'
require './lib/feedparser/version.rb'

Hoe.spec 'feedparser' do

  self.version = FeedParser::VERSION

  self.summary = 'feedparser - web feed parser and normalizer (RSS, Atom, JSON Feed, HTML h-entry, etc.)'
  self.description = summary

  self.urls    = ['https://github.com/feedparser/feedparser']

  self.author  = 'Gerald Bauer'
  self.email   = 'wwwmake@googlegroups.com'

  # switch extension to .markdown for gihub formatting
  self.readme_file  = 'README.md'
  self.history_file = 'CHANGELOG.md'

  self.extra_deps = [
    ['logutils', '>=0.6.1'],
    ['textutils', '>=1.0.0'],
    ## ['oga', '>=3.2.0'],   note: oga is a "soft" dependency
  ]

  ###  todo: add fetcher dep for testing (e.g. development only)

  self.licenses = ['Public Domain']

  self.spec_extras = {
   required_ruby_version: '>= 2.2.2'
  }

end
