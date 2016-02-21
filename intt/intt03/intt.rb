#!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby

# ruby 1.8.7 on OS X Marverics
#
# 条件に見合った Finder 項目と、マウスポインタとの距離を繰り返し、出力する。

require 'osx/cocoa'
include OSX
OSX.require_framework 'ScriptingBridge'


#--------- ここから ---------
# 正規化した距離
@screenStr = `osascript -e 'tell application "Finder" to get bounds of window of desktop'`.split().values_at(2,3)
@screen = [@screenStr[0].to_f, @screenStr[1].to_f]

# メソッドチェーンを実現するためのモンキーパッチング
# カレントオブジェクト self については 以下を参照
# http://qiita.com/ToruFukui/items/be29968da6dc9d125315

Array.class_eval do
	def normalizeXY(vec)
		return [self[0]/vec[0].to_f, self[1]/vec[1].to_f]
	end
end

def getCGPoint()
	event=OSX::CGEventCreate(nil); 
	pos =  OSX::CGEventGetLocation(event); 
	return [pos.x,pos.y]
end

loop do
	p getCGPoint().normalizeXY(@screen)
	sleep(1)
end
