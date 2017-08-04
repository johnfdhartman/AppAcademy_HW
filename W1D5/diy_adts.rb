class Stack
  def initialize
    @stack = []
  end

  def add(el)
    @stack << el
  end

  def remove
    @stack.pop
  end

  def show
    @stack
  end
end

class Queue
  def initialize
    @queue = []
  end

  def enqueue(el)
    @queue.unshift(el)
  end

  def dequeue
    @queue.pop
  end

  def show
    @stack
  end
end

class Map
  def initialize
    @pairs = []
  end

  def assign(key,value)
    if lookup(key)
      remove(key)
    end
    @pairs << [key,value]
  end

  def lookup(key)
    val = nil
    @pairs.each do |pair|
      if pair[0] == key
        val = pair[1]
      end
    end
    val
  end

  def remove(key)
    @pairs.select! {|pair| pair[0] != key}
  end

  def show
    @pairs
  end
end
