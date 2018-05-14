class Cat

  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def greet
    puts "I'm a cat! My name is #{name}"
  end
end

kitty = Cat.new("Sophie")
kitty.greet