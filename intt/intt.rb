#!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby

# ruby 1.8.7 on OS X Marverics
#
# 条件に見合った Finder 項目名を出力する

require 'osx/cocoa'
include OSX
OSX.require_framework 'ScriptingBridge'
require 'item.rb'

# 拡張子; 定数的に
EXTS = Regexp.new('.*\.(aif|aiff|wav|mp3|jpg)', Regexp::IGNORECASE)


# =============================================================================
# メイン処理 - 1 ファイル抽出
finder = SBApplication.applicationWithBundleIdentifier("com.apple.finder")

files = finder.files

targets = [] 
	# finder.files のいくつかの要素への参照を保持するだけの配列。
	# 以降の操作はこの配列を介して情報取得する
for i in files
	if i.name.UTF8String.match(EXTS)   # マッチの都合、ここで NSString を String にキャスト
		puts sprintf('A target:     %s', i.name)
		targets.push(i) # FinderItemへの参照を格納したいだけ。
	end
end

puts sprintf('All files   [%s]', files.size)
puts sprintf('target files[%s]', targets.size)

for i in targets
	puts sprintf('%s,%s,%s,%s', i.name, i.desktopPosition.x, i.desktopPosition.y, i.URL)
end

# =============================================================================
# メイン処理 - 2 対象ファイルの座標を取得　& レポート

# 各種配列を作成する

names = files.arrayByApplyingSelector(:name)            # array of NSMutableString
poss = files.arrayByApplyingSelector(:desktopPosition)  # array of NSConcreteValue

# Posix path の組み立て
paths = files.arrayByApplyingSelector(:URL)             # array of NSMutableString

posixPaths = []
paths.each do |i| 
	posixPaths.push(NSURL.URLWithString(i).path)
end

# DESIGN: 2次元配列 a に座標情報を格納する
# 引くとき a[ItemIndex] 
#    シンプルにアクセスできるよう、余分だけど対象でないファイルの分も要素を確保しておく。
#    また、ItemIndex は 1からはじまるっぽいので、a[0] は欠番とする。
# 格納するとき 
#    a[ItemIndex][0] = position.x
#    a[ItemIndex][1] = position.y

p '====================================='

## 格納 (アプローチ2)
# index が飛んでいることがあるので、配列は大きめに確保する
# TODO : 関数化 initFrame(frames, targets)
ARR_SIZE = files.size + 10
frames = Array.new(ARR_SIZE).map{Array.new(2)}
for i in targets
	frames[i.index] = [i.desktopPosition.x, i.desktopPosition.y] # 参照がコピーされていないか心配
end

for i in 0..ARR_SIZE-1
	p sprintf('%s %d %d', i, frames[i][0], frames[i][1])
end

p '====================================='

sleep 10

# 変更の検知
# TODO: 構造化 & 前フレームの上書き & 差分の記録(送信可能な形態に)
for i in targets
	if i.desktopPosition.x != frames[i.index][0]
		puts sprintf('change in %s:%s posx[%s] => [%s]', i.index, i.name, frames[i.index][0], i.desktopPosition.x)
	else 
		puts sprintf('no changes in %s:%s', i.index, i.name)
	end
end

p '===================================== DONE!'

## 受取側で情報取得できるかどうか確認する。

# =============================================================================
# メイン処理 - 3 変更差分のレポート
# TODO: for loop, 前フレームとの比較

# =============================================================================
# 確認

