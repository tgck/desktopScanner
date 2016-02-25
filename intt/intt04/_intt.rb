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

d = getDesktopSize()
puts sprintf('SCREEN:%s %s', d[0], d[1])
puts '===================================='

# マウスの動きに応じて、毎フレーム距離をレポートする
loop do
	# マウス
	m = getMousePosition()
	puts sprintf('POSMOUS: %d %d', m[0], m[1])

	# 座標ども
	cnt = 0
	for i in items
		# puts sprintf('POS[%d]: %d %d', cnt, i[0], i[1])
		puts sprintf('POS[%d]: %d %d  DIST:[%d]', cnt, i[0], i[1], distance(i, m))
		cnt += 1
	end

	sleep(INTERVAL)
end