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
# Finder Items のファイル抽出
#
def getFinderItems(ext_patterns)
	finder = SBApplication.applicationWithBundleIdentifier("com.apple.finder")
	files = finder.files

	targets = [] # FinderItemへの参照を格納
	positions = []

	for i in files
		name = i.name
		if name.UTF8String.match(ext_patterns)
			targets.push(i)
		end
	end

	puts sprintf('* getFinderItems: match/all  [%s/%s]', targets.size, files.size)

	for i in targets
		positions.push([i.desktopPosition.x, i.desktopPosition.y])
	end

	#for i in targets
	#	puts sprintf('%s,%s,%s,%s', i.name, i.desktopPosition.x, i.desktopPosition.y, NSURL.URLWithString(i.URL).path)
	#end
	#return targets
	return positions
end
# =============================================================================
# マウス座標を返す
#
def getMousePosition()
	event = OSX::CGEventCreate(nil); 
	pos = OSX::CGEventGetLocation(event); 
	return [pos.x,pos.y]
end
# =============================================================================
# 2点間の距離
#
def distance(p2, p1)
	return ( (p2[0]-p1[0])**2 + (p2[1]-p1[1])**2 ) ** 0.5
end
# =============================================================================
# デスクトップ領域の解像度
#
def getDesktopSize()
	resultShStr = `osascript -e 'tell application "Finder" to get bounds of window of desktop'`
	sizeStr = resultShStr.split().values_at(2,3)
	return [sizeStr[0].to_i, sizeStr[1].to_i]
end