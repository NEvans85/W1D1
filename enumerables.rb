require "byebug"
class Array
  def my_each(&prc)
    for item in self do
      prc.call(item)
    end
  end

  def my_select(&prc)
    result = []
    self.my_each do |num|
      result << num if yield(num)
    end
    result
  end

  def my_reject(&prc)
    result = []
    self.my_each do |num|
      result << num unless yield(num)
    end
    result
  end

  def my_any?(&prc)
    my_each do |el|
      return true if yield(el)
    end
    false
  end

  def my_all?(&prc)
    my_each do |el|
      return false unless yield(el)
    end
    true
  end

  def my_flatten
    result = []
    my_each do |el|
      if el.class == Array
        result += el.my_flatten
      else
        result << el
      end
    end
    result
  end

  def my_zip(*args)
    result = []
    idx = 0
    my_each do |el|
      curr_arr = []
      curr_arr << el
      args.my_each { |arr| curr_arr << arr[idx] }
      result << curr_arr
      idx += 1
    end
    result
  end

  def my_rotate(num = 1)
    num += length until num > 0
    num.times { self.push(self.shift) }
    self
  end

  def my_join (seperator = '')
    result = ''
    my_each do |el|
      result += "#{el}#{seperator}"
    end
    result.chomp(seperator)
  end

  def my_reverse
    result = []
    idx = 0
    my_each do |_el|
      result << self[size - 1 - idx]
      idx += 1
    end
    result
  end
end
