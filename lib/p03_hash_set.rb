require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    num = key_to_hash(key)
    unless include?(key)
      self[num] << key
      @count += 1
      resize! if @count == num_buckets
    end
  end

  def include?(key)
    num = key_to_hash(key)
    self[num].include?(key)
  end

  def remove(key)
    num = key_to_hash(key)
    if include?(key)
      self[num].delete(key)
      @count -= 1
    end
  end

  private
  def key_to_hash(key)
    key.hash
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    old_store.flatten.each do |el|
      insert(el)
    end
  end
end
