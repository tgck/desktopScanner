#!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby

# ruby 1.8.7 on OS X Marverics
#
# 条件に見合った Finder 項目と、マウスポインタとの距離を繰り返し、出力する。

require 'osx/cocoa'
include OSX
OSX.require_framework 'ScriptingBridge'

INTERVAL = 1.0

# user scripts
require 'formulas.rb'

# ファイルとの距離をはかる(一度だけ)

extentions = Regexp.new('.*\.(aif|aiff)', Regexp::IGNORECASE)
items = getFinderItems(extentions)
for i in items
	#puts sprintf('POS:%s,%s,%s', i.desktopPosition.x, i.desktopPosition.y, NSURL.URLWithString(i.URL).path)
	puts sprintf('POS:%s,%s', i[0], i[1])
end

# マウスの動きに応じて、毎フレーム距離をレポートする

loop do
	# マウス
	m = getMousePosition()

	puts sprintf('POSMOUS: %d %d', m[0], m[1])

	cnt = 0
	# 座標ども
	for i in items
		#puts sprintf('POS[%02d]: %d %d', i.index, i.desktopPosition.x, i.desktopPosition.y)
		puts sprintf('POS[%d]: %d %d', cnt, i[0], i[1])
		cnt += 1
	end

	sleep(INTERVAL)
end