#!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby

# ruby 1.8.7 on OS X Marverics
#
# 条件に見合った Finder 項目と、マウスポインタとの距離を繰り返し、出力する。

require 'osx/cocoa'
include OSX
OSX.require_framework 'ScriptingBridge'

# 拡張子; 定数的に
EXTS = Regexp.new('.*\.(aif|aiff)', Regexp::IGNORECASE)

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
# メイン処理 - 1 ファイル抽出
finder = SBApplication.applicationWithBundleIdentifier("com.apple.finder")
files = finder.files

targets = [] 
	# finder.files のいくつかの要素への参照を保持するだけの配列。
	# 以降の操作はこの配列を介して情報取得する

for i in files
	name = i.name
	if name.UTF8String.match(EXTS)   # マッチの都合、ここで NSString を String にキャスト
		puts sprintf('A target:     %s', name)
		targets.push(i) # FinderItemへの参照を格納したいだけ。
	end
end

puts sprintf('All files   [%s]', files.size)
puts sprintf('target files[%s]', targets.size)

for i in targets
	puts sprintf('%s,%s,%s,%s', i.name, i.desktopPosition.x, i.desktopPosition.y, NSURL.URLWithString(i.URL).path)
end

# =============================================================================
# メイン処理 - 2 対象ファイルの座標を取得

# DESIGN: 2次元配列 a に座標情報を格納する
# 長さ: 条件を満たすファイルの数
# 各要素: [finderIndex, x, y]

p '====================================='

## 格納
ARR_SIZE = targets.size
frames = []

for i in targets
	frames.push([i.index, i.desktopPosition.x, i.desktopPosition.y]) # 参照がコピーされていないか心配
	sleep 1
end

for i in 0..ARR_SIZE-1
	p sprintf('DUMP: %s %s %s %s', i, frames[i][0], frames[i][1], frames[i][2])
end

p '====================================='

c = 1;
# ループ
loop do
	calcDistance(frames)
	p sprintf('===================================== %s %s', c, Time.now)
	c += 1;
	#sleep(1)
end

## 受取側で情報取得できるかどうか確認する。

# =============================================================================
# メイン処理 - 3 変更差分のレポート
# TODO: for loop, 前フレームとの比較

# =============================================================================
# 確認

