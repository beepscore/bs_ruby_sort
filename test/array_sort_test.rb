#!/usr/bin/env ruby

require 'test/unit'
require_relative '../lib/array_sort'

class ArraySortTest < MiniTest::Unit::TestCase

  def test_merge_bs()
    puts 'in test_merge_bs()'
    first_sorted_collection = [2, 7, 19, 40, 63]
    second_sorted_collection = [4, 5, 13, 38, 57, 90]
    expected_result = [2, 4, 5, 7, 13, 19, 38, 40, 57, 63, 90]
    actual_result = Array.merge_bs(first_sorted_collection, second_sorted_collection)
    assert_equal(expected_result, actual_result)
  end

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
