require 'singleton'

class LRU < SizedBidirectionalLinkedList
  attr_reader :node_hash, :count, :front_node, :back_node
  def initialize(max_size)
    @node_hash = Hash.new(nil)
    super
  end

  def add_node(el)
    key = el.hash
    new_node = LinkedNode.new(el, key, @front_node, @null_node)
    remove_node(new_node) unless @node_hash[key].nil?
    @node_hash[key] = new_node
    if @count == 0
      @back_node = new_node
    end
    @front_node.next_node = new_node
    @front_node = new_node
    @count+=1
  end

  def remove_node(node)
    node.prev_node.next_node = node.next_node
    node.next_node.prev_node = node.prev_node
    @node_hash[node.key] = nil
    @count -= 1
  end
end

class SizedBidirectionalLinkedList
  attr_reader :front_node, :back_node, :count
  def initialize(max_size)
    @null_node = NullNode.instance
    @front_node, @back_node = @null_node, @null_node
    @max_size = max_size
    @count = 0
  end

  def add_node(el, key=nil)
    new_node = LinkedNode.new(el, key, @front_node, @null_node)
    if @count == 0
      @back_node = new_node
    end
    @front_node.next_node = new_node
    @front_node = new_node
    @count+=1
  end

  def show
    out = []
    current_node = @back_node
    until current_node == @null_node
      out << current_node.val
      current_node = current_node.next_node
    end
    p out
  end

  def pop_from_bottom
    @back_node.next_node.prev_node = @null_node
    @back_node = @back_node.next_node
    @count -= 1
  end

end

class LinkedNode
  attr_reader :val
  attr_accessor :prev_node, :next_node

  def initialize(val, key, prev_node=nil, next_node=nil)
    @val = val
    @key = key
    @prev_node = prev_node
    @next_node = next_node
  end
end

class NullNode < LinkedNode

  attr_reader :key, :val, :prev_node, :next_node
  def initialize
    @key = nil
    @val = nil
    @prev_node = self
    @next_node = self
  end

  def prev_node=(val)
    nil
  end

  def next_node=(val)
    nil
  end

end
