desktopScanner
==============

#### What is This?

Finder 項目の座標をトラッキングするアプリケーションです。
結果をOSCフォーマットに従って標準出力します。
通信機能は持っていません。適当なOSCクライアントにパイプしてユーザアプリケーションに渡してください。
拡張子に ".aiff" をもつファインダ項目を抽出してトラックします。

A simple Finder-Item position tracker.
Result written to stdout, so use any OSC Client such as pyliblo for IPC.
Currently this tracks ".aiff" files only.

#### How to Use

```bash
ln -s xcode/dscan/build/Debug/desktopScanner ./dscan
./dscan | ./oscsender.py
```

#### Dependencies

* OS X Scripting Bridge Framework
		
#### Tested in

* Mac OS X 10.9.5
* Xcode 5.1.1
	
#### Known Problems

#### History

* 2014.9 Version 2  

* OSC通信機能を除去 Exclude OSC
* コマンドラインで起動する形式に変更。

	
* 2013.11 Version 1  

A prototype with dummy GUI (With Cocoa, Liblo)

