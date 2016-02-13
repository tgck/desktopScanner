#!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby

# ruby 1.8.7 on OS X Marverics
#
# Finder 項目の名前、座標、フルパス を出力する

require 'osx/cocoa'
include OSX
OSX.require_framework 'ScriptingBridge'
require 'item.rb'

# 時間計測
start_time = Time.now

# メイン処理
finder = SBApplication.applicationWithBundleIdentifier("com.apple.finder")

files = finder.files
names = files.arrayByApplyingSelector(:name)            # array of NSMutableString
poss = files.arrayByApplyingSelector(:desktopPosition)  # array of NSConcreteValue
paths = files.arrayByApplyingSelector(:URL)             # array of NSMutableString

posixPaths = []
paths.each do |i| 
	posixPaths.push(NSURL.URLWithString(i).path)
end

targets = []
for i in 0..files.length-1 do
	targets.push(Item.new(names[i], poss[i].pointValue.x, poss[i].pointValue.y, posixPaths[i]))
end

t = Time.now - start_time

# 確認
for i in targets
	i.print
end

# benchmark
c = files.length
STDERR.puts sprintf("\nINFO: scanned [%s] items [%.4f] seconds. => [%.4f]sec/item", c, t, t/c )
