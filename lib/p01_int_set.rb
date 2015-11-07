class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    # set the position that corresponds to the num to true
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    # set the position that corresponds to the num to false
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    # if MaxIntSet includes the value, it will return true
    @store[num]
  end

  private

  def is_valid?(num)
    # num has to be between 0 and the length of the array - 1
    num.between?(0, @store.length - 1)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    # check to see if the bucket includes num. If not, insert it to the bucket
    self[num] << num unless self[num].include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      self[num] << num
      @count += 1
      resize! if @count == num_buckets
    end
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    # create a new reference to the current array
    old_store = @store
    # create a new array that contains twice as many buckets as the existing one
    @store = Array.new(num_buckets * 2) { Array.new }
    # reset the count to zero
    @count = 0
    # iterate along the old_store array and insert the values to the new array
    old_store.flatten.each { |num| insert(num) }
  end
end
