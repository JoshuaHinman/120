class Cat
  COLOR = 'purple'
  def initialize(name)
    @name = name
  end

  def greeting
    puts "Hello! My name is #{@name} and I'm a #{COLOR} cat"
  end
end

mittens = Cat.new("Mittens")
mittens.greeting