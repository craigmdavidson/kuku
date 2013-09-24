require 'test/unit'
require_relative "../lib/kuku.rb"

class TestArrayRank < Test::Unit::TestCase
  Company = Struct.new(:symbol, :pe_ratio, :return_on_capital, :dividend_yield)
  
  def setup
    @companies = [
      Company.new("KO", 19.4, 42.2, 3.2),
      Company.new("AAPL", 10.5, 32.1, 2.9),
      Company.new("AMZN", 65.2, 8.5, 0),
      Company.new("C", 14.2, 5.5, 1.2)]
  end
  
  def test_rank_by_multiple_object_attributes
    assert_equal ["KO", "AAPL", "C", "AMZN"], 
                  @companies.
                   rank.
                   lower_is_better(["pe_ratio"]).
                   higher_is_better(["return_on_capital", "dividend_yield"]).              
                   execute.
                   map{|c| c.symbol}
  end
end