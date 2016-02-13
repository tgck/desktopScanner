#!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby

# ruby 1.8.7 on OS X Marverics

# デーモンとして起動し マウスの座標を標準出力する
# TODO: 正規化

# 出力例
# $ ./track.rb 
# 960.97 340.21
# 991.62 340.21
# 993.36 340.21

require 'osx/cocoa'

while true
	event=OSX::CGEventCreate(nil); 
	pt = OSX::CGEventGetLocation(event); 
	#print pt.x, ':', pt.y; print "\n"
	puts sprintf("%.2f %.2f", pt.x, pt.y)
	sleep 0.1
end
