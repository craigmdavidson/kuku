require 'test/unit'
require_relative "../lib/kuku.rb"

class TestArraySummary < Test::Unit::TestCase
  
  def test_sum
    assert_equal 40, [2,4,4,4,5,5,7,9].stats.sum
  end
  
  def test_mean
    assert_equal 5, [2,4,4,4,5,5,7,9].stats.mean    
  end
  
  def test_standard_deviation
    assert_equal 2.0, [2,4,4,4,5,5,7,9].stats.standard_deviation        
  end
  
  def test_stability
    assert_equal 2.5, [2,4,4,4,5,5,7,9].stats.stability            
  end
  
  def test_average_growth
    assert_equal 27.65, [2,4,4,4,5,5,7,9].reverse.stats.average_growth.round(2)                
  end
end