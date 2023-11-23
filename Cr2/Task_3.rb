module Printable
  def print_info
    puts "Інформація про об'єкт (Клас:#{self.class} - ID: #{object_id}):"
    instance_variables.each do |var|
      puts "#{var}: #{instance_variable_get(var)}"
    end
  end
end

class Person
  include Printable

  def initialize(name, sex, age)
    @name = name
    @sex = sex
    @age = age
  end
end

class Book
  include Printable
  attr_accessor :title, :pages

  def initialize(title, pages)
    @title = title
    @pages = pages
  end
end

person = Person.new("Брендон Вайт","Ч", 35)
person.print_info

book = Book.new("Мова програмування Рубі", 465)
book.print_info
