###
## use TestTask from Rake for setting up testing
##   see https://docs.ruby-lang.org/en/2.1.0/Rake/TestTask.html

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/test_*.rb']
  t.libs = ['test']    ## (auto-)add to load path
end


task :default => :test
