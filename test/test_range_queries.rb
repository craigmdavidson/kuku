require 'test/unit'
require_relative "../lib/kuku.rb"

class TestRangeQueries < Test::Unit::TestCase

  def test_percent
    r = (41.2..43.5)
    assert_equal 0, r.percent(41.2)
    assert_equal 100, r.percent(43.5)    
    assert_equal 86.96, r.percent(43.2)        
  end

  def test_near_top?
    r = (41.2..43.5)
    assert r.near_top? 43.2  
    assert !r.near_top?(42.6)    
  end
  
  def test_near_bottom?
    r = (41.2..43.5)
    assert r.near_bottom? 41.3  
    assert !r.near_top?(42.6)    
  end
  
  def test_between
    assert 6.between? 5,8
    assert !3.between?(5,8)
    assert "b".between? "a","c"     
  end
end