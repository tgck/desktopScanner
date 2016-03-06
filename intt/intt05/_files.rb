#!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby

# ruby 1.8.7 on OS X Marverics
#
# 条件に見合った Finder 項目を抽出して、ファイルのロード命令を標準出力。
# Usage: (上位から呼ぶこと)
# 出力: 
# => 
# => 

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

