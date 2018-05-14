module Walkable
  def walk
    puts "Let's go for a walk!"
  end
end

class Cat
  attr_accessor :name
  def initialize(name)
    @name = name
  end

  def greet
    puts "I'm a cat! My name is #{name}"
  end
end

kitty = Cat.new("Sophie")
kitty.name = "Luna"
kitty.greet