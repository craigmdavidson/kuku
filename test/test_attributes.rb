require 'rubygems'
require 'test/unit'
require_relative "../lib/kuku.rb"

class Customer
  attr_accessor :name, :balance
  def initialize name, balance
    @name = name
    @balance = balance
  end
end
SCustomer = Struct.new :name, :balance

class TestAttributes < Test::Unit::TestCase
  def setup
    @expected = {:name => "Joe Smith", :balance => 420}
  end
  
  def test_objects_of_regular_classes_can_expose_their_attributes_as_a_hash
    c1 = Customer.new "Joe Smith", 420
    assert_equal "Joe Smith", c1.name
    assert_equal 420, c1.balance
    assert_equal @expected, c1.attributes
  end
  
  def test_objects_of_struct_classes_can_expose_their_attributes_as_a_hash
    c2 = SCustomer.new "Joe Smith", 420
    assert_equal "Joe Smith", c2.name
    assert_equal 420, c2.balance
    assert_equal @expected, c2.attributes
  end
  
  def test_setup_from_hash
    c1 = Customer.new "", 0
    c1.update_attributes @expected
    assert_equal @expected, c1.attributes
  end
  
  def test_setup_from_hash_with_struct
    c2 = SCustomer.new "", 0
    c2.update_attributes @expected
    assert_equal @expected, c2.attributes
  end
  
end