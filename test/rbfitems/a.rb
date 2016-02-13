#!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby

# ruby 1.8.7 on OS X Marverics
#
# 条件に見合った Finder 項目の座標を出力する

require 'osx/cocoa'
include OSX
OSX.require_framework 'ScriptingBridge'
require 'b.rb'

# 関数定義
def list(files)
	# dummy func
	for i in files do
		p = i.desktopPosition
		puts sprintf("%.2f %.2f", p.x, p.y)
	end
end

# メイン処理
finder = SBApplication.applicationWithBundleIdentifier("com.apple.finder")

files = finder.files
names = files.arrayByApplyingSelector(:name) # array of NSMutableString
poss = files.arrayByApplyingSelector(:desktopPosition)  # array of NSConcreteValue
paths = files.arrayByApplyingSelector(:URL)  # array of NSMutableString

posixPaths = []
paths.each do |i| 
	posixPaths.push(NSURL.URLWithString(i).path)
end

# list(files)

targets = []
for i in 0..files.length-1 do
#while i < files.length
	item = Item.new(names[i], poss[i].pointValue.x, poss[i].pointValue.y)
	#puts sprintf("%s %s %s", names[i], poss[i].pointValue.x, poss[i].pointValue.y)
	targets.push(item)
	item.print
end
#