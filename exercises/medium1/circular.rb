class CircularQueue
  def initialize(size)
    @queue = Array.new(size,nil)
    @end = size - 1
    @oldest = 0
    @next_open = 0
  end

  def enqueue(obj)
    @oldest = increment(@next_open) if @queue[@next_open]
    @queue[@next_open] = obj
    @next_open = increment(@next_open)
  end

  def dequeue
      value = @queue[@oldest]
      @queue[@oldest] = nil
      @oldest = increment(@oldest) if value != nil
      value
  end

  def increment(num)
    num += 1
    num = 0 if num > @end
    num
  end

  def show
    p @queue
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil