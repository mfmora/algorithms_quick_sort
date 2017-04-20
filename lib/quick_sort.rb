require 'byebug'
class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array.first if array.length <= 1
    pivot = array[rand(array.length)]
    left = []
    right = []
    array.each { |el| pivot >= el ? left << el : right << el }
    QuickSort.sort1(left) + [pivot] + QuickSort.sort2(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    return array if length < 2
    
    index = partition(array, start, length, &prc)
    sort2!(array, start, index - start, &prc)
    sort2!(array, index + 1, length - index + start - 1, &prc)

    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    pointer = start
    ((start + 1)...(start + length)).each do |idx|
      if prc.call(array[idx], array[start]) == -1
        array[pointer + 1], array[idx] = array[idx], array[pointer + 1]
        pointer += 1
      end
    end
    array[pointer], array[start] = array[start], array[pointer]
    pointer
  end
end
