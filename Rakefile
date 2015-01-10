require 'hoe'
require './lib/feedparser/version.rb'

Hoe.spec 'feedparser' do

  self.version = FeedParser::VERSION

  self.summary = 'feedparser - web feed parser and normalizer (RSS 2.0, Atom, etc.)'
  self.description = summary

  self.urls    = ['https://github.com/feedreader/feed.parser']

  self.author  = 'Gerald Bauer'
  self.email   = 'feedreader@googlegroups.com'

  # switch extension to .markdown for gihub formatting
  self.readme_file  = 'README.md'
  self.history_file = 'HISTORY.md'

  self.extra_deps = [
    ['logutils', '>=0.6.1'],
    ['textutils', '>=1.0.0'],     ### used just for testing; move into dev deps - how ???
  ]

  ###  todo: add fetcher dep for testing (e.g. development only)

  self.licenses = ['Public Domain']

  self.spec_extras = {
   required_ruby_version: '>= 1.9.2'
  }

end
