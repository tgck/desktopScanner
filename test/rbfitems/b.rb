#!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby

# ruby 1.8.7 on OS X Marverics

require 'osx/cocoa'
include OSX

# クラス
class Item
	def initialize(name, x, y)
		@name = name
		@x = x
		@y = y
		@path = ''
	end
	def print
		puts sprintf('%s, %s, %s', @name, @x, @y)
	end
end

# // クラス設計メモ //
# NSPoint を継承してクラス定義することはできる。
# が、実行時エラーとなる。
#
#a = NSPoint.new(10, 20)
#>> a
#=> #<OSX::NSPoint x=10.0, y=20.0>
#>> a.methods
#=> ["frozen?", "to_a", "to_s", "inspect", "methods", "singleton_methods", "protected_methods", "+", "-", "method", "private_methods", "send", "public_methods", "instance_eval", "instance_variables", "instance_exec", "instance_variable_get", "instance_variable_set", "instance_variable_defined?", "instance_of?", "kind_of?", "is_a?", "tap", "x", "x=", "y", "y=", "display", "extend", "hash", "==", "===", "=~", "in?", "inRect?", "object_id", "to_enum", "enum_for", "__id__", "nil?", "__send__", "equal?", "eql?", "id", "type", "class", "clone", "dup", "taint", "respond_to?", "tainted?", "untaint", "freeze"]

#class Item < OSX::NSPoint
#...

#b = Item.new(10,20)
#(irb):2: [BUG] Can't get bridge support structure for the given klass 0x1068fcdf0
#ruby 1.8.7 (2012-02-08 patchlevel 358) [universal-darwin13.0]

# そもそも親クラスのメソッドが見えない
#>> Item.methods
#=> ["frozen?", "to_a", "to_s", "inspect", "methods", "singleton_methods", "protected_methods", "method", "private_methods", "send", "public_methods", "<", ">", "instance_eval", "instance_variables", "_osx_const_missing_prev", "instance_method", "instance_exec", "instance_variable_get", "instance_variable_set", "instance_variable_defined?", "instance_of?", "kind_of?", "method_defined?", "is_a?", "tap", "public_method_defined?", "singleton_method_added", "private_method_defined?", "protected_method_defined?", "public_class_method", "private_class_method", "display", "module_eval", "module_exec", "fields", "class_eval", "class_exec", "opaque?", "new", "extend", "hash", "_real_class_and_mod", "included_modules", "include?", "name", "<=>", "==", "===", "ancestors", ">=", "<=", "=~", "_register_method", "allocate", "size", "instance_methods", "inherited", "public_instance_methods", "protected_instance_methods", "private_instance_methods", "method_added", "object_id", "class_variable_defined?", "constants", "encoding", "to_enum", "method_missing", "const_get", "enum_for", "__id__", "const_set", "nil?", "__send__", "autoload", "const_defined?", "equal?", "eql?", "const_missing", "id", "autoload?", "class_variables", "type", "class", "clone", "dup", "superclass", "taint", "respond_to?", "tainted?", "untaint", "freeze"]

