#!/usr/bin/env ruby

require 'pp'

class Array

  # each argument is an array sorted in ascending order
  # returns an array sorted in ascending order
  # if a and b are nil returns empty array, else if one argument is nil it returns the other
  def self.merge_bs(a, b)

    if (!a && !b)
      merged_array = []
    elsif (!a)
      merged_array = b
    elsif (!b)
      merged_array = a
    else
      merged_array = []

      if (a.length > b.length)
        #swap so that b is the longer array
        a, b = b, a
      end

      # prepend the smaller of the next two elements to the beginning of the merged array
      a_index = 0
      b_index = 0
      while (b_index < b.length) do
        if (a_index >= a.length)
          # we are past the end of a
          element_to_merge = b[b_index]
          b_index += 1
        elsif (b[b_index] < a[a_index])
          # b's current element is smaller than a's
          element_to_merge = b[b_index]
          b_index += 1
        else 
          element_to_merge = a[a_index]
          a_index += 1
        end
        puts "element_to_merge #{element_to_merge}"
        # prepend element_to_merge to beginning of merged_array
        # push is adding to beginning not end???
        merged_array = merged_array.push(element_to_merge)
      end
    end
    merged_array
  end

  # Extend class Array by adding another sort method  
  # Could use standard Array.sort() instead,
  # but do this as a learning exercise.
  def sort_bs_merge()
    sorted = self
    # Divide: Divide the n-element sequence to be sorted into two subsequences of n/2 elements each.
    split_arrays = self.split_left_right_bs
    left_side = split_arrays[:left_side]
    right_side = split_arrays[:right_side]
    pp "self #{self} left_side #{left_side} right_side #{right_side}"

    #Conquer: Sort the two subsequences recursively using Merge Sort.
    if left_side != [] || right_side != []
      sorted_left = left_side.sort_bs_merge
      pp "sorted_left #{sorted_left}"
      sorted_right = right_side.sort_bs_merge
      pp "sorted_right #{sorted_right}"
      #Combine: Merge the two sorted subsequences to produce the sorted answer.
      sorted = Array.merge_bs(sorted_left, sorted_right)
      pp "sorted #{sorted}"
      #http://www.catonmat.net/blog/mit-introduction-to-algorithms-part-two/
    end
    sorted
    #
    # take any two elements from unsorted array e.g. first two
    # compare and merge them to get one sorted array of length 2
    # continue until have n/2 sorted pairs

    # take any two sorted pairs
    # merge them to get one sorted array of length 4
    # merge operates on sorted arrays, so it knows the first elements are always lowest
    # continue until have n/4 sorted arrays

    # take any two sorted arrays of length 4
    # merge them to get one sorted array of length 8
    # continue until have n/8 sorted arrays
    #
    # continue until have 1 sorted array

    #merge_bs(self.split_left_right_bs)
  end

  # split_left_right_bs returns a hash with a left_side array and a right_side array.
  #if array is empty, returns hash with :left_side empty array and :right_side empty array.
  #if array has odd number of elements, :left_side is shorter than :right_side
  def split_left_right_bs()
    left_side = []
    right_side = []

    if [] != self
      # exclusive range
      left_side = self[0 ... self.length()/2]
      # inclusive range
      right_side = self[self.length()/2 .. self.length()]
    end

    {:left_side => left_side, :right_side => right_side} 
  end

end
