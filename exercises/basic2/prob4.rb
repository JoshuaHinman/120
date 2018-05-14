class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def rename(name)
    self.name = name
  end

  def identify
    self
  end

  def self.generic_greeting
    "Hello! I'm a cat!"
  end

  def greeting
    "Hello! My name is #{name}"
  end
end

kitty = Cat.new("Fuzzy")
kitty.name = "Simon"
p kitty.name
p kitty.identify
p Cat.generic_greeting
p kitty.greeting
