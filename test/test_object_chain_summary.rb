require 'test/unit'
require_relative "../lib/kuku.rb"

class TestObjectChainSummary < Test::Unit::TestCase

  def setup
    s = Struct.new(:a)    
    @n = [s.new(2.0), s.new(3.0), s.new(2.0), s.new(4.2), s.new(2.0), s.new(4.0), s.new(4.0), s.new(2.5), s.new(3.3)]
  end

  def test_mean    
    first = @n.as_chain
    assert_equal 2.0, first.a
    assert_equal (@n.map{|m| m.a}).mean, first.mean("a", 9)
  end

end