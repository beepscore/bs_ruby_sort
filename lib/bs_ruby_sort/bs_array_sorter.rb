#!/usr/bin/env ruby

require 'pp'

module BsRubySort

  class BsArraySorter

    def self.array_of_arrays_of_length(an_array, subarray_length)
      # http://stackoverflow.com/questions/4689186/how-do-you-select-every-nth-item-in-an-array
      array_of_arrays = []
      an_array.each_slice(subarray_length) do |subarray|
        array_of_arrays.push(subarray)
      end
      array_of_arrays
    end

    # returns the smallest positive integer exponent n such that an_array.length <= (2 ** n)
    def self.log_two_length(an_array)
      log_length = 0
      if an_array.length > 1
        #log2 returns float
        # .ceil rounds up (ceiling)
        log_length = Math.log2(an_array.length).ceil
      end
      log_length
    end

    # each argument is an array sorted in ascending order
    # returns an array sorted in ascending order
    # if a and b are nil returns empty array, else if one argument is nil it returns the other
    def self.bs_merge(a, b)

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

        # bs_merge operates on sorted arrays. Their first elements are always lowest.
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

    # bs_sort_merge is non-recursive
    def self.bs_sort_merge(an_array)

      if an_array.length < 2
        sorted = an_array
      else
        collected_arrays = self.array_of_arrays_of_length(an_array, 1)
        pp "collected_arrays #{collected_arrays}"

        merged_arrays = []

        max_number_of_merges = (self.log_two_length(an_array) + 1)
        (1 ... max_number_of_merges).each do |length_exponent|

          puts "length_exponent = #{length_exponent}"

          # Take two subarrays at a time.
          # Each subarray has length up to 2**length_exponent.
          # merge them to get an array of sorted arrays of length 2n
          collected_arrays.each_slice(2) do |subarray| 
            # if subarray has length 1, subarray[1] returns nil
            merged_array = (self.bs_merge(subarray[0], subarray[1]))
            pp "merged array #{merged_array}"
            merged_arrays.push(merged_array)
            pp "merged_arrays #{merged_arrays}"
          end

          collected_arrays = merged_arrays
          merged_arrays = []
        end # end range loop

        sorted = collected_arrays.first
      end
      sorted
    end

    # if array has odd number of elements, right_side is longer than left_side
    # if array is empty, returns empty array
    def self.right_side(an_array)
      right_side = nil

      if 0 == an_array.length
        right_side = []
      elsif 1 == an_array.length
        right_side = an_array
      else
        # inclusive range
        right_side = an_array[an_array.length()/2 .. an_array.length()]
      end

      right_side
    end

    # if array has odd number of elements, left_side is shorter than right_side
    # if array is empty, returns empty array
    def self.left_side(an_array)
      left_side = nil

      if 1 >= an_array.length
        left_side = []
      else
        # exclusive range
        left_side = an_array[0 ... an_array.length()/2]
      end

      left_side
    end

    def self.sort_recursive(an_array)
      sorted = an_array

      if (an_array.length > 1)
        # Divide: Divide the n-element sequence to be sorted into two subsequences of n/2 elements each.
        left_side = self.left_side(an_array)
        right_side = self.right_side(an_array)

        #Conquer: Sort the two subsequences recursively using Merge Sort.

        if (1 >= left_side.length)
          sorted_left = left_side
        else
          sorted_left = self.sort_recursive(left_side)
        end

        if (1 >= right_side.length)
          sorted_right = right_side
        else
          sorted_right = self.sort_recursive(right_side)
        end

        #Combine: Merge the two sorted subsequences to produce the sorted answer.
        sorted = self.bs_merge(sorted_left, sorted_right)
      end
      sorted
    end

  end

end
