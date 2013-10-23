require 'test/unit'
require_relative "../lib/kuku.rb"

def wrap list
  list.map{|i| {"value" => i, "value_again" => i}}
end


class TestUnchained < Test::Unit::TestCase
  def setup
    @list = wrap (1...3000).to_a
    @first = @list.as_chain
  end

  def test_unchained
    unchained = @first.as_unchained_array
    assert_equal @list, unchained
  end
  
end


require 'profile'    

@list = wrap (1...3000).to_a
@first = @list.as_chain
unchained = @first.as_unchained_array



