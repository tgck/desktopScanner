#!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby

# ruby 1.8.7 on OS X Marverics
#
# 条件に見合った Finder 項目と、マウスポインタとの距離を繰り返し、出力する。

# =============================================================================
# 距離を計算する。内部で CGEvent を呼ぶ
def calcDistance(frame)
	event=OSX::CGEventCreate(nil); 
	pt = OSX::CGEventGetLocation(event); 
	puts sprintf("%.2f %.2f", pt.x, pt.y)

	for i in frame
		x = i[1]
		y = i[2]
		distance = ((x - pt.x)**2 + (y - pt.y)**2) ** 0.5
		puts sprintf('DISTANCE: %d : %s %s %.2f %.2f', distance, x, y, pt.x, pt.y) # FIXME
	end
end
# =============================================================================