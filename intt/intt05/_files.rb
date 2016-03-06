#!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby

# ruby 1.8.7 on OS X Marverics
#
# ファイルのロード命令を標準出力する
# 
# コンフィグ[0]: OSCメッセージテンプレート
# コンフィグ[1]: 抽出ファイルの拡張子
# => 	
# 出力: 
# => intt05:540$ ./_files.rb -c
# => * getFinderItems: match/all:[2/49]
# => /dscand/path/0/ s /Users/tani/Desktop/01.aif
# => /dscand/path/1/ s /Users/tani/Desktop/02.aif

# configs
OSC_STRING = "/dscand/path/ID/"
PATTERN = '.*\.(aif|aiff)'

# require
require 'osx/cocoa'
include OSX
OSX.require_framework 'ScriptingBridge'

# user scripts
require 'formulas.rb'

### Finder 項目の情報収集
EXT = Regexp.new(PATTERN, Regexp::IGNORECASE)
itemDataArr = getFinderItems(EXT)
paths = itemDataArr[2]

cnt = 0
for i in paths
	str = OSC_STRING.gsub(/ID/, cnt.to_s)
	puts sprintf("%s s %s", str, i.to_s)
	cnt += 1
end

