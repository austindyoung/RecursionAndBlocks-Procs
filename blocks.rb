require 'byebug'

class Array
  def my_each(&block)
    i = 0
    while i < length
      block.call(self[i])
      i += 1
    end
  end

  def my_map(&block)
    array = []
     my_each do |el|
       array << block.call(el)
     end
    array
  end

  def my_select(&block)
    my_map do |el|
      block.call(el) ? el : nil
    end.compact
  end

  def my_inject(base = nil, &operator)
     so_far = (base.nil? ? shift : base)
     my_each do |el|
       so_far = operator.call(so_far, el)
     end
     so_far
  end

  # def my_sort!(&comparator)
  #   return self if length < 2
  #   comparator ||= Proc.new { |a,b| a <=> b }
  #   pivot_index = rand(length - 1)
  #   left, right = [],[]
  #   (0...length).each do |idx|
  #     comparator.call(self[pivot_index], self[idx]) == -1 ? right << self[idx] : left << self[idx] if idx != pivot_index
  #   end
  #   temp = left.my_sort! + [self[pivot_index]] + right.my_sort!
  #   self.clear
  #   self << temp
  # end

  def my_sort!(&comparator)
    comparator ||= Proc.new { |a,b| a <=> b }
    sorted = false
    until sorted == true
      (1...length).each do |idx|
        sorted = true
        left, right = self[idx-1], self[idx]
        self[idx-1], self[idx], sorted = right, left, false if comparator.call(left, right) == 1
      end
    end
  end

  def my_sort(&comparator)
    comparator ||= Proc.new { |a,b| a <=> b }
    duplicate = self.dup
    duplicate.my_sort!(&comparator)
    duplicate
  end

end

def eval_block(*args, &blk)
  blk.call(*args)
end
