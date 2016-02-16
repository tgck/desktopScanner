#!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby

# ruby 1.8.7 on OS X Marverics
#
# 条件に見合った Finder 項目名を出力する

require 'osx/cocoa'
include OSX
OSX.require_framework 'ScriptingBridge'

# 拡張子; 定数的に
EXTS = Regexp.new('.*\.(aif|aiff|jpg|txt)', Regexp::IGNORECASE)

# =============================================================================
# 変更検知
def scanDifference(frame, currentFiles)
	# 変更の検知
	# TODO: 構造化 & 前フレームの上書き & 差分の記録(送信可能な形態に)
	for i in currentFiles
		idx = i.index
		prev_val = frame[idx][0]
		curr_val = i.desktopPosition.x
		if prev_val != curr_val
			p 'change!'
			puts sprintf('change in %s:%s posx[%s] => [%s]', idx, '#i.name', frame[idx][0], curr_val)
			# フレーム更新
			frame[idx][0] = curr_val
		else 
			# puts sprintf('no changes in %s:%s', i.index, i.name)
		end
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
# メイン処理 - 2 対象ファイルの座標を取得　& レポート

# DESIGN: 2次元配列 a に座標情報を格納する
# 引くとき a[ItemIndex] 
#    シンプルにアクセスできるよう、余分だけど対象でないファイルの分も要素を確保しておく。
#    また、ItemIndex は 1からはじまるっぽいので、a[0] は欠番とする。
# 格納するとき 
#    a[ItemIndex][0] = position.x
#    a[ItemIndex][1] = position.y

p '====================================='

## 格納 (アプローチ2)
ARR_SIZE = files.size + 10
frames = Array.new(ARR_SIZE).map{Array.new(2)}

for i in targets
	idx = i.index
	pos = i.desktopPosition
	frames[idx] = [pos.x, pos.y] # 参照がコピーされていないか心配
end

for i in 0..ARR_SIZE-1
	p sprintf('%s %d %d', i, frames[i][0], frames[i][1])
end

p '====================================='

c = 1;
# ループ
loop do
	scanDifference(frames, targets)
	p sprintf('===================================== %s %s', c, Time.now)
	c += 1;
	sleep(5)
end

## 受取側で情報取得できるかどうか確認する。

# =============================================================================
# メイン処理 - 3 変更差分のレポート
# TODO: for loop, 前フレームとの比較

# =============================================================================
# 確認

