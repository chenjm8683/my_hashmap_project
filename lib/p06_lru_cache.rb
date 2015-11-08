require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      # find the reference to the link from the HashMap
      link = @map.get(key)
      # Move the Link to tail in the LinkedList
      update_link!(link)
      # Return the value from the link
      link.val
    else
      calc!(key)
      eject! if count > @max
      @store.last.val
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    @store.insert(key, val)
    @map.set(key, @store.last)
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    @store.move_to_tail!(link)
  end

  def eject!
    key = @store.first.key
    @store.pop
    @map.delete(key)
  end
end
