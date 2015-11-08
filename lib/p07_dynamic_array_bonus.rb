class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return nil if i >= @count || (i + @count) < 0
    i += @count if i < 0
    @store[i]
  end

  def []=(i, val)
    raise IndexError if (i + @count) < 0
    i += @count if i < 0
    resize!(i * 2) if i > capacity
    @store[i] = val
    @count = i + 1 if i >= @count
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.each do |el|
      return true if el == val
    end
    false
  end

  def push(val)
    resize! if @count == capacity
    @store[@count] = val
    @count += 1
  end

  def unshift(val)
    resize! if @count + 1 == capacity
    idx = @count - 1
    until idx < 0
      @store[idx + 1] = @store[idx]
      idx -= 1
    end
    @store[0] = val
    @count += 1
    # resize! if @count == capacity
  end

  def pop
    return nil if @count == 0
    val = last
    @store[@count - 1] = nil
    @count -= 1
    val
  end

  def shift
    return nil if @count == 0
    val = first
    idx = 0
    while idx < @count - 1
      @store[idx] = @store[idx + 1]
      idx += 1
    end
    @count -= 1
    val
  end

  def first
    @count == 0 ? nil : @store[0]
  end

  def last
    @count == 0 ? nil : @store[@count - 1]
  end

  def each(&prc)
    idx = 0
    while idx < @count
      prc.call(@store[idx])
      idx += 1
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    if other.class == Array
      return false unless other.length >= @count && same_elements?(other)
      idx = @count
      while idx < other.length
        return false unless other[idx] == nil
        idx += 1
      end
      return true
    else
      return false unless @count == other.count
      return same_elements?(other)
    end
  end



  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def same_elements?(other)
    idx = 0
    while idx < @count
      return false unless self[idx] == other[idx]
      idx += 1
    end
    true
  end

  def resize!(cap = capacity * 2)
    old_store = @store
    @store = StaticArray.new(cap)
    idx = 0
    while idx < @count
      @store[idx] = old_store[idx]
      idx += 1
    end
  end
end
