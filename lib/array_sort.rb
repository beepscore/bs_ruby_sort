#!/usr/bin/env ruby

class Array

  # Extend class Array by adding another sort method  
  # Could use standard Array.sort() instead,
  # but do this as a learning exercise.
  def sort_bs_merge()
    puts 'not implemented yet'
    []
  end

  # split_left_right_bs returns a hash with a left_side array and a right_side array.
  #if array has odd number of elements, :left_side is shorter than :right_side
  def split_left_right_bs()
    if 0 == self.length
      left_side = []
      right_side = []
    else
      # exclusive range
      left_side = self[0 ... self.length()/2]
      # inclusive range
      right_side = self[self.length()/2 .. self.length()]
    end
    {:left_side => left_side, :right_side => right_side} 
  end

end
    # algorithm
    #
    # Divide: Divide the n-element sequence to be sorted into two subsequences of n/2 elements each.
    #Conquer: Sort the two subsequences recursively using Merge Sort.
    #Combine: Merge the two sorted subsequences to produce the sorted answer.
    #http://www.catonmat.net/blog/mit-introduction-to-algorithms-part-two/
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
