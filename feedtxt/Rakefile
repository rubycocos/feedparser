require 'hoe'
require './lib/feedtxt/version.rb'

Hoe.spec 'feedtxt' do

  self.version = Feedtxt::VERSION

  self.summary = "feedtxt - reads Feed.TXT a.k.a. RSS (Really Simple Sharing) 5.0 ;-) - feeds in text (unicode) - publish & share posts, articles, podcasts, 'n' more"
  self.description = summary

  self.urls    = ['https://github.com/feedtxt/feedtxt']

  self.author  = 'Gerald Bauer'
  self.email   = 'wwwmake@googlegroups.com'

  # switch extension to .markdown for gihub formatting
  self.readme_file  = 'README.md'
  self.history_file = 'HISTORY.md'

  self.licenses = ['Public Domain']

  ### todo
  ##   add deps e.g. props gem for INI.load


  self.spec_extras = {
    required_ruby_version: '>= 1.9.2'
  }

end
