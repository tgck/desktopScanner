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

# for Console Animation
STEP = 20
UNIT_VAL = 1.0/STEP

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
	# p = getCGPoint().normalizeXY(@screen)
	# print( p[0], "      ", p[1], "\r")
	# STDOUT.flush
	# sleep(1)

	p = getCGPoint().normalizeXY(@screen)


	where_x = (p[0] / UNIT_VAL).round
	where_y = (p[1] / UNIT_VAL).round
	
	#print(where_x, ",", where_y, "\n")
	#puts sprintf("%02d,%02d", where_x, where_y)
	STDOUT.flush

	print("[")
	for i in 1..STEP do 
		if (i==where_x)
			print("*")
		else
			print(" ")
		end
	end
	print ('] [')
	for i in 1..STEP do 
		if (i==where_y)
			print("*")
		else
			print(" ")
		end
	end
	print("]", "\r")
	STDOUT.flush
	sleep(0.1)
end

# 1.0 を 20ステップなら、1ステップは0.05
# 0.05 を UNIT_VAL と定義
# X, Y それぞれの中に UNIT_VAL がいくつ含まれるかを算出
# for i in 1..STEP でまわして、idx != UNIT_VAL なら スペースをprint
#                           idx == UNIT_VAL なら * をprint
