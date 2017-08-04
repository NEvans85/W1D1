def factors(num)
  (1..num).to_a.select { |i| (num % i).zero? }
end

class Array
  def bubble_sort!(&prc)
    sorted = false
    idx = 0
    until sorted
      sorted = true
      idx = 0
      while idx < length
        if yield(self[idx], self[idx + 1]) == 1
          self[idx], self[idx + 1] = self[idx + 1], self[idx]
          sorted = false
        end
        idx += 1
      end
    end
    self
  end

  def bubble_sort(&prc)
    dup.bubble_sort!(&prc)
  end
end

def substrings(string)
  result = []

  (0..string.length - 1).each do |idx1|
    ((idx1)..(string.length - 1)).each do |idx2|
      result << string[idx1..idx2]
    end
  end

  result
end
