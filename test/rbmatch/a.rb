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
for i in 1..files.length-1
	if names[i].UTF8String.match(/.*\.(aif|aiff|jpg|txt)/)   # マッチの都合、ここで NSString を String にキャスト
		matchedFiles.push(files[i])
	end
end

t = Time.now - start_time

# 確認
for obj in matchedFiles
	puts obj.name
end

# benchmark
c = matchedFiles.length
STDERR.puts sprintf("\nINFO: [%s] matched against [%s] total files.", c, files.length )
STDERR.puts sprintf("INFO: scanned [%s] items [%.4f] seconds. => [%.4f]sec/item", c, t, t/c )
