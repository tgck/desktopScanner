#!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby

# ruby 1.8.7 on OS X Marverics
# a.rb

require 'optparse'
params = ARGV.getopts('c')

p params['c']

if params['c'] then
	p 'you did specify the option [-c].!!!'
	p 'hoge'
else
	p 'you did NOT specify the option [-c].'
	p 'piyo'
end



