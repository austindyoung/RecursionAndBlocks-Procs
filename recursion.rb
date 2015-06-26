require_relative "blocks"

def range_loop(first, last)
  return [last] if last == first
  range_loop(first + 1, last).unshift(first)
end

def range(first, last)
  range_loop(first + 1, last - 1)
end

def iterative_sum(array)
  array.my_inject(&:+)
end

def recursive_sum(array)
  return 0 if array.length == 0
  array.shift + recursive_sum(array)
end

def first_exponent(num, exp)
  return 1 if exp == 0
  first_exponent(num, exp-1) * num
end

def second_exponent(num, exp)
    return 1 if exp == 0
    return num if exp == 1
    exp % 2 == 0 ? second_exponent(num, exp / 2) ** 2 : num * (second_exponent(num, (exp - 1)/2) ** 2)
end

def deep_dup(array)
  return array if array.class != Array
  duplicate = array.dup
  duplicate.map! do |arr|
    deep_dup(arr)
  end
  duplicate
end

def fibs(n)
  return [0] if n == 0
  return [0, 1] if n == 1
  current_fibs = fibs(n - 1)
  current_fibs << (current_fibs[-2] + current_fibs[-1])
end

def binary_search(array, query)
  binary_search_helper(0, array.length - 1, array, query)
end

def binary_search_helper(low, high, array, query)
  mid = (high - low + 1) / 2
  return mid if array[mid] == query
  if query < array[mid]
    binary_search_helper(low, mid, array, query)
  else
    binary_search_helper(mid, high, array, query)
  end
end

def make_change(sum, coins)
  ways = ways_to_make_change(sum, coins).select { |way| way }
  best_way = ways[0]
  ways.each {|new_way| best_way = new_way if new_way.length < best_way.length}
  best_way
end

def ways_to_make_change(sum, coins)
  return [nil] if sum < 0
  return [[]] if sum == 0
  return [nil] if coins == [] && sum > 0
  ways_without = ways_to_make_change(sum, coins[1..-1])
  ways_with = ways_to_make_change(sum - coins[0], coins).map do |way|
    way ? way.unshift(coins[0]) : nil
  end
  ways_with + ways_without.compact
end

class Array
  def merge_sort(&comparator)
    comparator ||= Proc.new { |a,b| a <=> b }
    return self if length == 1
    mid = length/2 - 1
    left, right = self[0..mid], self[mid + 1..-1]
    (left.merge_sort).merge(right.merge_sort, &comparator)
  end

  def merge(arr2, &comparator)
    comparator ||= Proc.new { |a,b| a <=> b }
    merged = []
    until self.empty? || arr2.empty?
      comparator.call(self[0], arr2[0]) == -1 ? merged << self.shift : merged << arr2.shift
    end
    merged + self + arr2
  end
end

def b_strings(n, two_set)
  return [[]] if n == 0
  previous_strings = b_strings(n - 1, two_set)
  b_strings_ending_in_first = previous_strings.map { |b_string| b_string.dup.push(two_set[0]) }
  b_strings_endining_second = previous_strings.map { |b_string| b_string.dup.push(two_set[1]) }
  b_strings_ending_in_first + b_strings_endining_second
end

def subsets(set)
  return [[]] if set == []
  prev_subsets = subsets(set[1..-1])
  prev_subsets + prev_subsets.map { |prev_set| prev_set.dup + [set[0]] }
end
