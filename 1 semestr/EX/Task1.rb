# Інтерфейс ітератора
class Iterator
  def has_next
    raise NotImplementedError, "#{self.class} не реалізував метод '#{__method__}'"
  end

  def next
    raise NotImplementedError, "#{self.class} не реалізував метод '#{__method__}'"
  end
end

# Конкретний ітератор для масиву
class ArrayIterator < Iterator
  def initialize(array)
    @array = array
    @index = 0
  end

  def has_next
    @index < @array.size
  end

  def next
    result = @array[@index]
    @index += 1
    result
  end
end

# Клас, який використовує ітератор для обходу масиву
class ArrayProcessor
  def initialize(array)
    @iterator = ArrayIterator.new(array)
  end

  def process
    while @iterator.has_next
      puts "Обробка: #{@iterator.next}"
    end
  end
end

# Використання ітератора для обходу масиву
array = [1, 2, 3, 4, 5]
processor = ArrayProcessor.new(array)
processor.process
