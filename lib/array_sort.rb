#!/usr/bin/env ruby

require 'pp'

class Array

  def array_of_arrays_of_length(subarray_length)
    # http://stackoverflow.com/questions/4689186/how-do-you-select-every-nth-item-in-an-array
    array_of_arrays = []
    self.each_slice(subarray_length) do |subarray| 
      array_of_arrays.push(subarray)
    end
    array_of_arrays
  end


  # returns the smallest positive integer exponent n such that self.length <= (2 ** n)
  def log_two_length()
    log_length = 0
    if self.length > 1
      #log2 returns float
      # .ceil rounds up (ceiling)
      log_length = Math.log2(self.length).ceil
    end
    log_length
  end


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

      # merge_bs operates on sorted arrays. Their first elements are always lowest.
      # prepend the smaller of the next two elements to the beginning of the merged array
      a_index = 0
      b_index = 0
      while ((a_index < a.length) || (b_index < b.length)) do
        # we still have elements to merge

        if ((a_index < a.length) && (b_index < b.length)) 
          # we still have elements in each array to merge
          if (b[b_index] < a[a_index])
            # b's current element is smaller than a's
            element_to_merge = b[b_index]
            b_index += 1
          else
            # a's current element is smaller than or equal to b's
            element_to_merge = a[a_index]
            a_index += 1
          end
        elsif (a_index >= a.length) 
          # we are past the end of a
          element_to_merge = b[b_index]
          b_index += 1
        else 
          # we are past the end of b
          element_to_merge = a[a_index]
          a_index += 1
        end
        # prepend element_to_merge to beginning of merged_array
        # push is adding to beginning not end???
        merged_array = merged_array.push(element_to_merge)
      end
    end
    merged_array
  end


  # Extend class Array by adding some sort methods
  # Could use standard Array.sort() instead,
  # but do this as a learning exercise.

  # sort_merge_bs is non-recursive
  def sort_merge_bs()

    if self.length < 2
      sorted = self
    else
      unsorted_array_of_sorted_arrays = self.array_of_arrays_of_length(1)
      pp "unsorted_array_of_sorted_arrays #{unsorted_array_of_sorted_arrays}"

      array_of_sorted_arrays = []

      max_number_of_merges = (self.log_two_length + 1)
      (1 ... max_number_of_merges).each do |length_exponent|

        puts "length_exponent = #{length_exponent}"

        # Take two subarrays at a time.
        # Each subarray has length up to 2**length_exponent.
        # merge them to get an array of sorted arrays of length 2n
        unsorted_array_of_sorted_arrays.each_slice(2) do |subarray| 
          # if subarray has length 1, subarray[1] returns nil
          merged_array = (Array.merge_bs(subarray[0], subarray[1]))
          pp "merged array #{merged_array}"
          array_of_sorted_arrays.push(merged_array)
          pp "array_of_sorted_arrays #{array_of_sorted_arrays}"
        end

        unsorted_array_of_sorted_arrays = array_of_sorted_arrays
        array_of_sorted_arrays = []
      end # end range loop

      sorted = unsorted_array_of_sorted_arrays.first
    end
    sorted
  end


  def sort_recursive()
    sorted = self

    if (self.length > 1)
      # Divide: Divide the n-element sequence to be sorted into two subsequences of n/2 elements each.
      left_side = self.split_left_right_bs[:left_side]
      right_side = self.split_left_right_bs[:right_side]

      #Conquer: Sort the two subsequences recursively using Merge Sort.

      if (1 >= left_side.length)
        sorted_left = left_side
      else 
        sorted_left = left_side.sort_recursive
      end 

      if (1 >= right_side.length)
        sorted_right = right_side
      else 
        sorted_right = right_side.sort_recursive
      end 

      #Combine: Merge the two sorted subsequences to produce the sorted answer.
      sorted = Array.merge_bs(sorted_left, sorted_right)
    end
    sorted
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
