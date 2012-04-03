#!/usr/bin/env ruby

require 'test/unit'
require_relative '../lib/array_sort'

class ArraySortTest < MiniTest::Unit::TestCase

  def test_array_of_arrays_of_length()
    puts 'in test_array_of_arrays_of_length()'
    an_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    expected_result = [[1, 2], [3, 4], [5, 6], [7, 8], [9, 10], [11]]
    actual_result = an_array.array_of_arrays_of_length(2)
    pp actual_result
    assert_equal(expected_result, actual_result, 'incorrect array of arrays of length 2')
  end


  def test_merge_bs()
    puts 'in test_merge_bs()'
    first_sorted_collection = nil
    second_sorted_collection = nil
    expected_result = []
    actual_result = Array.merge_bs(first_sorted_collection, second_sorted_collection)
    assert_equal(expected_result, actual_result, 'merge should handle both collections nil')

    first_sorted_collection = nil
    second_sorted_collection = []
    expected_result = []
    actual_result = Array.merge_bs(first_sorted_collection, second_sorted_collection)
    assert_equal(expected_result, actual_result, 'merge should handle first collection nil second empty')

    first_sorted_collection = []
    second_sorted_collection = nil
    expected_result = []
    actual_result = Array.merge_bs(first_sorted_collection, second_sorted_collection)
    assert_equal(expected_result, actual_result, 'merge should handle first empty second nil')

    first_sorted_collection = []
    second_sorted_collection = []
    expected_result = []
    actual_result = Array.merge_bs(first_sorted_collection, second_sorted_collection)
    assert_equal(expected_result, actual_result, 'merge should handle both collections empty')

    first_sorted_collection = []
    second_sorted_collection = [-5, 2, 7]
    expected_result = [-5, 2, 7]
    actual_result = Array.merge_bs(first_sorted_collection, second_sorted_collection)
    assert_equal(expected_result, actual_result, 'merge should handle first collection empty')

    first_sorted_collection = [2, 7, 19, 40, 63]
    second_sorted_collection = []
    expected_result = [2, 7, 19, 40, 63]
    actual_result = Array.merge_bs(first_sorted_collection, second_sorted_collection)
    assert_equal(expected_result, actual_result, 'merge should handle second collection empty')

    first_sorted_collection = [9]
    second_sorted_collection = [3]
    expected_result = [3, 9]
    actual_result = Array.merge_bs(first_sorted_collection, second_sorted_collection)
    assert_equal(expected_result, actual_result)

    first_sorted_collection = [2, 7, 19, 40, 63]
    second_sorted_collection = [4, 5, 13, 38, 57, 90]
    expected_result = [2, 4, 5, 7, 13, 19, 38, 40, 57, 63, 90]
    actual_result = Array.merge_bs(first_sorted_collection, second_sorted_collection)
    assert_equal(expected_result, actual_result)
  end

  # test Array standard push method
  def test_push()
    puts 'in test_push()'
    an_array = []
    expected_result = [2]
    actual_result = an_array.push(2)
    assert_equal(expected_result, actual_result, 'pushed array incorrect')

    an_array = [1, 2, 5]
    expected_result = [1, 2, 5, 4]
    actual_result = an_array.push(4)
    assert_equal(expected_result, actual_result, 'pushed array incorrect')
  end

  # test Array standard sort method
  def test_sort()
    puts 'in test_sort()'
    unsorted_numbers = [4, 3, 1, 2]
    expected_result = [1, 2, 3, 4]
    actual_result = unsorted_numbers.sort
    assert_equal(expected_result, actual_result, 'sorted array incorrect')
  end

  def test_sort_recursive()
    puts 'in test_sort_recursive()'
    unsorted_numbers = [23, 4, 3, 0, 19, 7]
    # use Array standard sort method as a benchmark
    expected_result = unsorted_numbers.sort
    actual_result = unsorted_numbers.sort_recursive
    assert_equal(expected_result, actual_result, 'sorted array incorrect')
  end

  def test_sort_recursive_empty()
    puts 'in test_sort_recursive_empty()'
    unsorted_numbers = []
    expected_result = unsorted_numbers.sort
    actual_result = unsorted_numbers.sort_recursive
    assert_equal(expected_result, actual_result, 'should return empty array')
  end

  def test_sort_recursive_length_one()
    puts 'in test_sort_recursive_length_one()'
    unsorted_numbers = [-6]
    expected_result = unsorted_numbers.sort
    actual_result = unsorted_numbers.sort_recursive
    assert_equal(expected_result, actual_result, 'sorted array incorrect')
  end

  def test_sort_recursive_length_two()
    puts 'in test_sort_recursive_length_two()'
    unsorted_numbers = [1, 3]
    expected_result = unsorted_numbers.sort
    actual_result = unsorted_numbers.sort_recursive
    assert_equal(expected_result, actual_result, 'sorted array incorrect')

    unsorted_numbers = [9, 3]
    expected_result = unsorted_numbers.sort
    actual_result = unsorted_numbers.sort_recursive
    assert_equal(expected_result, actual_result, 'sorted array incorrect')
  end

  def test_split_left_right_bs
    puts 'in test_split_left_right_bs()'
    unsorted_numbers = [6, 5, 4]
    expected_result = {:left_side => [6], :right_side => [5, 4]}
    actual_result = unsorted_numbers.split_left_right_bs()
    assert_equal(expected_result, actual_result)    
  end

  def test_split_left_right_bs_empty
    puts 'in test_split_left_right_bs_empty()'
    unsorted_numbers = []
    expected_result = {:left_side => [], :right_side => []}
    actual_result = unsorted_numbers.split_left_right_bs()
    assert_equal(expected_result, actual_result)    
  end

  def test_split_left_right_bs_length_one
    puts 'in test_split_left_right_bs_length_one()'
    unsorted_numbers = [-3]
    expected_result = {:left_side => [], :right_side => [-3]}
    actual_result = unsorted_numbers.split_left_right_bs()
    assert_equal(expected_result, actual_result)    
  end

  def test_split_left_right_bs_length_two
    puts 'in test_split_left_right_bs_length_two()'
    unsorted_numbers = [28, 14]
    expected_result = {:left_side => [28], :right_side => [14]}
    actual_result = unsorted_numbers.split_left_right_bs()
    assert_equal(expected_result, actual_result)    
  end

end
