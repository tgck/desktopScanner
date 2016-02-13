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
list(files)

f = files[0]
i = Item.new(f.name, f.desktopPosition.x, f.desktopPosition.y)
i.print
