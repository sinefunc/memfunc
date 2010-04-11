require 'rubygems'
require 'test/unit'
require File.dirname(__FILE__) + '/../vendor/contest/lib/contest'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'memfunc'

class Test::Unit::TestCase
end
