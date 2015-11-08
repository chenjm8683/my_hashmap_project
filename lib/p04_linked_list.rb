class Link
  attr_accessor :key, :val, :next

  def initialize(key = nil, val = nil, nxt = nil)
    @key, @val, @next = key, val, nxt
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable

  attr_reader :head

  def initialize
    @head = Link.new
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    current_link = first
    until current_link.next == nil
      current_link = current_link.next
    end
    current_link
  end

  def empty?
    first.key == nil
  end

  def get(key)
    current_link = first
    loop do
      return current_link.val if current_link.key == key
      current_link = current_link.next
      return nil if current_link == nil
    end
  end

  def get_link(key)
    current_link = first
    loop do
      return current_link if current_link.key == key
      current_link = current_link.next
      return nil if current_link == nil
    end
  end

  def include?(key)
    current_link = first
    loop do
      return true if current_link.key == key
      current_link = current_link.next
      return false if current_link == nil
    end
  end

  def insert(key, val)
    if empty?
      @head.key = key
      @head.val = val
    elsif include?(key)
      get_link(key).val = val
    else
      last.next = Link.new(key, val)
    end
  end

  def remove(key)
    previous_link = nil
    current_link = first
    loop do
      break if current_link.key == key
      previous_link = current_link
      current_link = current_link.next
      return nil if current_link == nil
    end
    if previous_link == nil
      @head = first.next
    else
      previous_link.next = current_link.next
    end
  end

  def each(&prc)
    current_link = first
    loop do
      prc.call(current_link)
      break if current_link.next == nil
      current_link = current_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
