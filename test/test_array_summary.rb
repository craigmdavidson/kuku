require 'test/unit'
require_relative "../lib/kuku.rb"

class TestArraySummary < Test::Unit::TestCase
  
  def test_sum
    assert_equal 40, [2,4,4,4,5,5,7,9].sum
  end
  
  def test_mean
    assert_equal 5, [2,4,4,4,5,5,7,9].mean    
  end
  
  def test_standard_deviation
    assert_equal 2.0, [2,4,4,4,5,5,7,9].standard_deviation        
  end
  
  def test_stability
    assert_equal 2.5, [2,4,4,4,5,5,7,9].stability            
  end
  
  def test_average_growth
    assert_equal 27.65, [2,4,4,4,5,5,7,9].reverse.average_growth.round(2)                
  end
end