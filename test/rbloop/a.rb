#!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby

# ruby 1.8.7 on OS X Marverics
#
# 無限ループする

c = 1;

loop do
	puts sprintf('%d:%s', c, Time.now)
	c += 1;
	if (c==100001) 
		raise StopIteration
	end
end

