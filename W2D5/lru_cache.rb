require 'singleton'

class LRUCache
  attr_reader :count, :least_recent, :most_recent

    def initialize(max_size)
      @big_hash = Hash.new({})
      @max_size = max_size
      @count = 0
      @least_recent = {}
      @most_recent = {}
      @null_node = {value: nil, key: nil, prev_node: nil, next_node: nil}
    end

    def add_to_top(el)
      #creates a {value, key, prev_node, next_node} Hash
      #adds it to the big hash
      #links up the previous most_recent to this one
      new_node = {el: el, key: el.hash,
                  prev_node: @most_recent, next_node: @null_node}
      @least_recent = new_node if @count == 0
      @most_recent[:next_node] = new_node
      @most_recent = new_node
      @count+=1
    end

    def remove_el(el)
      key = el.hash
      node = @big_hash[key]
      if node == @least_recent
        remove_from_bottom(node, key)
      elsif node == @most_recent
        remove_from_top(node, key)
      else
        remove_from_middle(node,key)
      end
      count+=1
    end

    def remove_from_middle(node,key)
      node = @big_hash[key]
      node[:prev_node][:next_node] = node[:next_node]
      node[:next_node][:prev_node] = node[:prev_node]
      @big_hash.delete(key)
      count -=1
    end

    def remove_from_bottom(node, key)
      @least_recent = node[:next_node]
      @least_recent[:prev_node] = @null_node
      @big_hash.delete(key)
    end

    def remove_from_top(node, key)
      @most_recent = node[:prev_node]
      @most_recent[:next_node] = @null_node
      @big_hash.delete(key)
    end


    def show
      arr = []
      current_node = @least_recent
      until current_node == @null_node
        arr << current_node[:el]
        current_node = current_node[:next_node]
      end
      p arr
    end

    def [](key)
      node = @big_hash.key[]
    end

end
