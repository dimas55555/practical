
module MyModule
  module Logger
    def log(message)
      puts "Логування: #{message}"
    end
  end
end

class MyClass
  include MyModule::Logger
end

obj = MyClass.new
obj.log("Hello, world!")

module ComparableMixin
  def compare(other)
    puts "#{self} порівняний з #{other}"
  end
end

class MyClass
  include ComparableMixin
end

obj1 = MyClass.new
obj2 = MyClass.new

obj1.compare(obj2)

module Iterable
  def iterate
    puts "Ітерація по #{self}"
  end
end

class MyCollection
  include Iterable
end

collection = MyCollection.new
collection.iterate
