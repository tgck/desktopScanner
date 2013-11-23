desktopScanner
==============

finder Item position tracker and report with OSC

To Get Finder.h
	sdef /System/Library/CoreServices/Finder.app | sdp -fh --basename Finder

Dependencies
	- liblo 0.26 (http://liblo.sourceforge.net/)
	- Scripting Bridge Framework
		
Tested in
	- Mac OS X 10.6.8
	- Xcode 3.2.6
	
Known Problems
	- can't build in "Release".

