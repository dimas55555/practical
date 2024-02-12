class DynamicClass
  define_method :dynamic_method do
    puts "Це динамічно визначений метод!"
  end
end

dynamic_instance = DynamicClass.new
dynamic_instance.dynamic_method
puts "\n"
class PropertyManipulation
  attr_accessor :example_property

  def initialize(value)
    @example_property = value
  end
end

obj = PropertyManipulation.new("Початкове значення")
puts obj.example_property

obj.send(:example_property=, "Нове значення")
puts obj.example_property
puts "\n"

def example_method
  raise "Це приклад виключення"
end

begin
  example_method
rescue => e
  puts "Помилка: #{e.message}"
end
puts "\n"

obj = "Приклад об'єкта з метакласом"

metaclass = class << obj; self; end
metaclass.class_eval do
  def custom_method
    puts "Це спеціальний метод для цього об'єкта!"
  end
end

obj.custom_method
puts "\n"

class DynamicMethods
  define_method :dynamic_method do |value|
    puts "Значення: #{value}"
  end
end

dynamic_instance = DynamicMethods.new
dynamic_instance.send(:dynamic_method, "Динамічне значення")
puts "\n"
class MissingMethodExample
  def method_missing(method_name, *args, &block)
    puts "Викликаний невизначений метод: #{method_name}"
  end
end

obj = MissingMethodExample.new
obj.undefined_method