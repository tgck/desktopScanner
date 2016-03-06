#!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby

# ruby 1.8.7 on OS X Marverics
#
# 条件に見合った Finder 項目と、マウスポインタとの距離を繰り返し、出力する。

####require 'osx/cocoa'
####include OSX
####OSX.require_framework 'ScriptingBridge'

INTERVAL = 1.0

# user scripts
#require 'formulas.rb'

###
### Finder 項目の情報収集
###

####EXT = Regexp.new('.*\.(aif|aiff)', Regexp::IGNORECASE)
itemDataArr = getFinderItems(EXT)
positions = itemDataArr[0]

# Desktop の大きさ
DESKTOP_SIZE = getDesktopSize()

### マウスの動きに応じて、毎フレーム距離をレポートする
### 重い計算と描画を処理を分ける(update & draw)
loop do
	# マウス
	m = getMousePosition()

	# update ================================
	dists = []
	for i in positions
		#dists.push(distance(i,m))  # 単純な距離
		dists.push(n_distance(i,m)) # 正規化された距離(1)
		#dists.push(n2_distance(i,m)) # 正規化された距離(2) FIXME
	end

	# draw ==================================
	cnt = 0
	for i in 1..positions.size
		printline(dists, cnt)
		cnt += 1
	end

	sleep(INTERVAL)
end