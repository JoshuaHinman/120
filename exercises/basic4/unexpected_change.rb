class Person
  def name=(name)
    name = name.split
    @first = name[0]
    @last = name[1]
  end
  def name
    "#{@first} #{@last}"
  end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name