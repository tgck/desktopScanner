#!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby

# ruby 1.8.7 on OS X Marverics
# TODO: 正規化

require 'osx/cocoa'

while true
	event=OSX::CGEventCreate(nil); 
	pt = OSX::CGEventGetLocation(event); 
	#print pt.x, ':', pt.y; print "\n"
	puts sprintf("%.2f %.2f", pt.x, pt.y)
	sleep 0.1
end
