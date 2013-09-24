require 'test/unit'
require_relative "../lib/kuku.rb"

class TestArrayAsChain < Test::Unit::TestCase
  Company = Struct.new(:symbol, :name)
  
  def setup
    @companies = [
      Company.new("AAPL", "Apple"), 
      Company.new("MSFT", "Microsoft"),
      Company.new("CAT", "Caterpiller"),
      Company.new("KO", "The Coco Cola Company")]    
    @first = @companies.as_chain
  end
  
  def test_first_objects_previous_object_should_be_nil
    assert_nil @first.previous        
  end
  
  def test_last_objects_next_object_should_be_nil
    assert_nil @companies.last.next
  end
  
  def test_a_chained_object_knows_its_next_object
    assert_equal "AAPL", @first.symbol
    assert_equal "MSFT", @first.next.symbol
    assert_equal "Microsoft", @first.next.name    
    assert_equal "CAT", @first.next.next.symbol        
  end
    
  def test_chained_object_knows_the_previous_object
    assert_equal "CAT", @companies.last.previous.symbol
    assert_equal "MSFT", @companies.last.previous.previous.symbol
    assert_equal "AAPL", @companies.last.previous.previous.previous.symbol
  end
  
  def test_unchaining_the_first_chained_object_gives_the_array
    assert_equal @companies, @first.as_unchained_array
  end
  
  def test_unchaining_subsequent_chained_objects_gives_an_array_of_the_rest_of_the_chain
    assert_equal [
        Company.new("MSFT", "Microsoft"),
        Company.new("CAT", "Caterpiller"),
        Company.new("KO", "The Coco Cola Company")], @first.next.as_unchained_array
    assert_equal [
        Company.new("CAT", "Caterpiller"),
        Company.new("KO", "The Coco Cola Company")], @first.next.next.as_unchained_array
  end
  
  def test_nil
    assert_equal nil, [].as_chain
    assert_equal nil, nil.next    
    assert_equal nil, nil.previous     
    assert_equal [nil], nil.as_unchained_array      
  end
end