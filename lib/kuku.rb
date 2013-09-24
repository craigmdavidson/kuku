module ChainAnalysis
  def stability method_name, n=8
    elements(method_name, n).stability    
  end
  def average_growth method_name, n=8
    elements(method_name, n).average_growth
  end  
  def mean method_name, n=8
    elements(method_name, n).mean
  end 
  def elements method_name, n=8
    as_unchained_array[0..(n-1)].map{|s| s.method(method_name).call}  
  end
end

class Object
  include ChainAnalysis
  attr_accessor :next, :previous
  def nvl v
    v ? v : 0
  end
  def as_number
    return self if self.class != String
    signing = start_with?("(") && end_with?(")") ? -1 : 1
    s = gsub(",", "").gsub("--", "").gsub("(", "").gsub(")", "")
    !s.empty? ? s.to_i * signing : 0
  end
  def as_unchained_array
    return Array[self] if self.next == nil
    a = Array[self] << self.next.as_unchained_array
    a.flatten
  end
end


class Array 
  def as_chain
    self.size.times{|i| 
      a = self[i+1]
      b = self[i-1]
      (self[i].next = a) if a
      (self[i].previous = b) if (b && i > 0)
    }
    self[0]
  end
  def rank
    Rank.new self
  end
  def total
    Totaler.new self
  end
  def product
    reduce{|k,v| k*v} 
  end
  def geometric_mean
    product ** (1/size.to_f) 
  end
  def sum
    reduce{|k,v| k+v} 
  end
  def mean
    sum / size 
  end
  def standard_deviation
    Math.sqrt variance
  end
  def variance
    ((reduce(0){|k,v| k+(v-mean)**2})) / size.to_f
  end  
  def stability
    mean / (standard_deviation > 1.0 ? standard_deviation : 1)
  end  
  def growth
    result = Array.new
    (size-1).times {|i| result << ((self[i].to_f - self[i+1].to_f)/self[i+1].to_f) * 100 }
    result
  end
  def average_growth
    growth.mean
  end  
end


class Range
  def percent n
    a = last - first
    b = n - first
    ((b / a) * 100).round(2)
  end
  def near_top? n, definition = 25.0
    percent(n).between?((100-definition), 100+definition)
  end
  def near_bottom? n, definition = 25.0
    percent(n).between?(0, definition)
  end
end


RankedObject = Struct.new(:rank, :object)
class Rank
  def initialize objects
    @objects = objects
    @all_rankings = Array.new
  end
  def size
    @objects.size
  end
  def higher_is_better criteria
    rank_reverse true, criteria
  end
  def lower_is_better criteria
    rank_reverse false, criteria 
  end
  def rank_reverse do_reverse, criteria 
    criteria.each{|criterion|
      i = 0
      sorted = @objects.sort_by {|o| eval("o.#{criterion}")}
      sorted = sorted.reverse if do_reverse
      @all_rankings << sorted.collect{|o| RankedObject.new(i+=1, o) }
    }
    self    
  end
  def total_for a
    @all_rankings.collect{|rank| 
      rank.select{|ranked_item| ranked_item.object == a}[0].rank}.
      inject{|sum, i| sum + i}
  end  
  def execute
    @objects.
      collect{|o| RankedObject.new(total_for(o), o)}.
      sort_by{|r| r.rank}.
      collect{|r| r.object}
  end
end