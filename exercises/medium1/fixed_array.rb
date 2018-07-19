class FixedArray

  def initialize(size)
    @arr = Array.new(size,nil)
  end

  def [](idx)
    @arr.fetch(idx)
  end

  def []=(idx, val)
    @arr[idx] = val
  end

  def to_a
    @arr.clone
  end

  def to_s
    to_a.to_s
  end
end

a = FixedArray.new(5)
a[3] = "hi"
p a[3]
p a.to_a
p a.to_s