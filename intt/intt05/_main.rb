#!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby

# ruby 1.8.7 on OS X Marverics
#
# - ロード命令と、ポジショントラックの分割
# - 引数c の場合に アニメーション抑止して、テキストだけとする

require 'optparse'
params = ARGV.getopts('c')
p params['c']

if params['c'] then

	# ファイルロード命令
	require '_files.rb'

	# 読み込み完了待ち
	sleep 5	

	# 距離のレポート
	require '_positions.rb'

else
	# シングルで使う時用
	require 'console.rb'
end


