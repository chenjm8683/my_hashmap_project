class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil, nxt = nil, prev = nil)
    @key, @val, @next, @prev = key, val, nxt, prev
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
    @tail = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

# singly linked list implementation
=begin
  def last
    current_link = first
    until current_link.next == nil
      current_link = current_link.next
    end
    current_link
  end
=end

  def last
    @tail
  end


  def empty?
    first.key == nil
  end

  def get(key)
    current_link = first
    loop do
      return nil if current_link.nil? || current_link.key.nil?
      return current_link.val if current_link.key == key
      current_link = current_link.next
    end
  end

  def get_link(key)
    current_link = first
    loop do
      return nil if current_link.nil? || current_link.key.nil?
      return current_link if current_link.key == key
      current_link = current_link.next
    end
  end

  def include?(key)
    current_link = first
    loop do
      return false if current_link.nil? || current_link.key.nil?
      return true if current_link.key == key
      current_link = current_link.next
    end
  end

  def insert(key, val)
    if empty?
      @head.key = key
      @head.val = val
    elsif include?(key)
      get_link(key).val = val
    else
      last.next = Link.new(key, val, nil, last)
      @tail = last.next
    end
  end
# singly linked list implementation
=begin
  def remove(key)
    previous_link = nil
    current_link = first
    loop do
      break if current_link.key == key
      previous_link = current_link
      current_link = current_link.next
      return nil if current_link == nil
    end
    # the following code will only excute when key is found
    if previous_link == nil
      @head = first.next
      # create a new Link as @head if the original head had the key and was the only link
      first ||= Link.new
    else
      previous_link.next = current_link.next
    end
    current_link.val
  end
=end
  def remove(key)
    current_link = first
    loop do
      break if current_link.key == key
      current_link = current_link.next
      return nil if current_link == nil
    end
    # the following code will only excute when key is found
    # when head has the key and is the only link
    if first == last
      @head = Link.new
    elsif current_link == first
      @head = current_link.next
      @head.prev = nil
    elsif current_link == last
      @tail = current_link.prev
      @tail.next = nil
    else
      current_link.prev.next = current_link.next
      current_link.next.prev = current_link.prev
    end
    current_link.val
  end

  def push(link)
    @tail.next = link
    link.prev = @tail
    @tail = link
  end

  def unshift(link)
    @head.prev = link
    link.next = @head
    @head = link
  end

  def pop
    temp = first
    if first.next == nil
      @head = Link.new
    else
      @head = @head.next
      @head.prev = nil
    end
    temp
  end

  def move_to_tail!(link)
    unless link == last
      if link == first
        @head = link.next
        @head.prev = nil
      else
        link.prev.next = link.next
        link.next.prev = link.prev
      end
      @tail.next = link
      link.prev = @tail
      @tail = link
    end
  end

  def each(&prc)
    current_link = first
    loop do
      break if current_link.nil? || current_link.key.nil?
      prc.call(current_link)
      current_link = current_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
