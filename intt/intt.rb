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
names = files.arrayByApplyingSelector(:name)            # array of NSMutableString

# 配列をつめ直すアプローチは なぜかエラーになる
# 違うアプローチで。

# 途中

## delete_if 使ってみる？
## http://simanman.hatenablog.com/entry/2013/03/20/013808

for i in files
	if i.name.UTF8String.match(EXTS)   # マッチの都合、ここで NSString を String にキャスト
		puts 'that is a target'
	else
		puts 'that is a NOT a target'
		puts i.name
		files.pop
	end
end



puts files.size

# =============================================================================
# メイン処理 - 2 対象ファイルの座標を取得　& レポート

# 各種配列を作成する

puts 'a', files.size
puts 'b', files[0]
puts 'c', files[0].desktopPosition.x # 取れてる
puts 'd', files[0].desktopPosition.y # 取れてる

names2 = files.arrayByApplyingSelector(:name)            # array of NSMutableString
poss = files.arrayByApplyingSelector(:desktopPosition)  # array of NSConcreteValue
	# ここが 通らない...
	# => /System/Library/Frameworks/RubyCocoa.framework/Resources/ruby/osx/objc/oc_wrapper.rb:50: [BUG] Segmentation fault
	# => ruby 1.8.7 (2012-02-08 patchlevel 358) [universal-darwin13.0]
	# => Abort trap: 6

paths = files.arrayByApplyingSelector(:URL)             # array of NSMutableString

puts 'e', files.class
puts 'f', names[0]
puts 'g', paths[0]

posixPaths = []
paths.each do |i| 
	posixPaths.push(NSURL.URLWithString(i).path)
end

#items = []
#for i in 0..targetFiles.length-1 do
#	items.push(Item.new(names2[i], poss[i].pointValue.x, poss[i].pointValue.y, posixPaths[i]))
#end

#for i in items
#	i.print
#end

# =============================================================================
# メイン処理 - 3 変更差分のレポート
# TODO: for loop, 前フレームとの比較






# =============================================================================
# 確認

