#!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby

# ruby 1.8.7 on OS X Marverics
#
# 条件に見合った Finder 項目名を出力する

require 'osx/cocoa'
include OSX
OSX.require_framework 'ScriptingBridge'

# 時間計測
start_time = Time.now

# メイン処理
finder = SBApplication.applicationWithBundleIdentifier("com.apple.finder")

files = finder.files
names = files.arrayByApplyingSelector(:name)            # array of NSMutableString

count = 0
matchedFiles = []
for i in names
	if str = i.UTF8String.match(/.*\.aif/)   # マッチの都合、ここで NSSTring を
		puts "NSString: " +  i
		puts "String:   " +  str[0]
		count += 1
	end
end


t = Time.now - start_time

# 確認

# benchmark
c = files.length
STDERR.puts sprintf("\nINFO: [%s] file matched", count)
STDERR.puts sprintf("INFO: scanned [%s] items [%.4f] seconds. => [%.4f]sec/item", c, t, t/c )
