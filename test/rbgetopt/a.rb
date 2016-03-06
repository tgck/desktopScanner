#!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby

# ruby 1.8.7 on OS X Marverics
# a.rb

require 'optparse'
params = ARGV.getopts('c')
p params['c']

if params['c'] then
	p 'hoge'
else
	p 'piyo'
end



