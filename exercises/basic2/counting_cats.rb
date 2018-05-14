class Cat
  @@cat_count = 0

  def initialize
    @@cat_count += 1
  end

  def self.total
    @@cat_count
  end
end

kitty = Cat.new
Cat.new
Cat.new
p Cat.total