class Person
  attr_accessor :secret
end

guy = Person.new
guy.secret = "Shh... this is s secret"
p guy.secret