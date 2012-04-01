#!/usr/bin/env ruby

require 'test/unit'
require_relative '../lib/array_sort'

class ArraySortTest < MiniTest::Unit::TestCase

  # test Array standard sort method
  def test_sort()
    puts 'in test_sort()'
    unsorted_numbers = [4, 3, 1, 2]
    expected_result = [1, 2, 3, 4]
    actual_result = unsorted_numbers.sort
    assert_equal(expected_result, actual_result, 'sorted array incorrect')
  end

  def test_sort_bs_merge()
    puts 'in test_sort_bs_merge()'
    unsorted_numbers = [23, 4, 3, 0, 19, 7]
    # use Array standard sort method as a benchmark
    expected_result = unsorted_numbers.sort
    actual_result = unsorted_numbers.sort_bs_merge
    assert_equal(expected_result, actual_result, 'sorted array incorrect')
  end

  def test_split_left_right_bs
    puts 'in test_split_left_right_bs()'
    unsorted_numbers = [6, 5, 4]
    expected_result = {:left_side => [6], :right_side => [5, 4]}
    actual_result = unsorted_numbers.split_left_right_bs()
    puts actual_result
    assert_equal(expected_result, actual_result)    
  end

  def test_split_left_right_bs_empty
    puts 'in test_split_left_right_bs_empty()'
    unsorted_numbers = []
    expected_result = {:left_side => [], :right_side => []}
    actual_result = unsorted_numbers.split_left_right_bs()
    puts actual_result
    assert_equal(expected_result, actual_result)    
  end

end
