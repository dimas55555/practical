class MyClass
  def instance_method
    puts "Це метод екземпляра"
  end

  def self.class_method
    puts "Це метод класу"
  end
end

obj = MyClass.new
obj.instance_method
MyClass.class_method
