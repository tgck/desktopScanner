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

EXT = Regexp.new('.*\.(aif|aiff)', Regexp::IGNORECASE)
items = getFinderItems(EXT)
for i in items
	#puts sprintf('POS:%s,%s,%s', i.desktopPosition.x, i.desktopPosition.y, NSURL.URLWithString(i.URL).path)
	puts sprintf('POS:%s,%s', i[0], i[1])
end

DESKTOP_SIZE = getDesktopSize()

# マウスの動きに応じて、毎フレーム距離をレポートする
# 重い計算と描画を処理を分ける(update & draw)
loop do
	# マウス
	m = getMousePosition()

	# update ================================
	dists = []
	for i in items
		dists.push(distance(i,m))
	end

	# draw ==================================
	clear
	print_header(DESKTOP_SIZE, m)

	cnt = 0
	for i in items
		#puts sprintf('POS:[%d]', dists[i]) ##ここがエラー！！！！！
		#puts sprintf('POS[%d]: %d %d DIST:[%d]', cnt, items[0], items[1], dists[cnt])
		cnt += 1
	end

	sleep(INTERVAL)
end