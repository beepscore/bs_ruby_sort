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
