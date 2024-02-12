# Модуль Printable містить print_info, що виводить інформацію про об'єкт
module Printable
  def print_info
    # Виводимо заголовок інформації про об'єкт: клас та ідентифікатор об'єкта
    puts "Інформація про об'єкт (Клас:#{self.class} - ID: #{object_id}):"

    # Для кожної інстанційної змінної виводимо її ім'я та значення
    instance_variables.each do |var|
      puts "#{var}: #{instance_variable_get(var)}"
    end
  end
end

# Клас Person містить ім'я, стать та вік
class Person
  include Printable

  def initialize(name, sex, age)
    @name = name
    @sex = sex
    @age = age
  end
end

# Клас Book має назву та кількість сторінок
class Book
  include Printable
  attr_accessor :title, :pages

  def initialize(title, pages)
    @title = title
    @pages = pages
  end
end

# Створюємо об'єкт класу Person і виводимо інформацію про нього
person = Person.new("Брендон Вайт", "Ч", 35)
person.print_info

# Створюємо об'єкт класу Book і виводимо інформацію про нього
book = Book.new("Мова програмування Рубі", 465)
book.print_info
