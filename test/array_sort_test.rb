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

end
