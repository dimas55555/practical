# Базовий клас для напоїв
class Beverage
  attr_reader :client_name

  def initialize(client_name)
    @client_name = client_name
  end

  # Метод для обчислення вартості напою (за замовчуванням - 0)
  def cost
    0
  end

  # Метод для отримання опису напою з вказанням клієнта
  def description
    "Напій клієнта #{@client_name}"
  end
end

# Конкретний напій - Кава
class Coffee < Beverage
  # Вартість кави
  def cost
    15
  end

  # Опис кави з вказанням клієнта
  def description
    "Кава клієнта #{@client_name}"
  end
end

# Декоратор для додавання молока до напою
class MilkDecorator
  def initialize(beverage, client_name)
    @beverage = beverage
    @client_name = client_name
  end

  # Обчислення вартості з молоком
  def cost
    @beverage.cost + 3
  end

  # Розширення опису з молоком і вказанням клієнта
  def description
    "#{@beverage.description}, з молоком клієнта #{@client_name}"
  end
end

# Декоратор для додавання цукру до напою
class SugarDecorator
  def initialize(beverage, client_name)
    @beverage = beverage
    @client_name = client_name
  end

  # Обчислення вартості з цукром
  def cost
    @beverage.cost + 2.5
  end

  # Розширення опису з цукром і вказанням клієнта
  def description
    "#{@beverage.description}, з цукром клієнта #{@client_name}"
  end
end

# Використання
client_name = 'Іван'
coffee = Coffee.new(client_name)
coffee_with_milk = MilkDecorator.new(coffee, client_name)
coffee_with_milk_and_sugar = SugarDecorator.new(coffee_with_milk, client_name)

puts coffee_with_milk_and_sugar.description # Виведе: "Кава клієнта Іван, з молоком клієнта Іван, з цукром клієнта Іван"
puts coffee_with_milk_and_sugar.cost        # Виведе: 20.5

client_name2 = 'Даня'
coffee2 = Coffee.new(client_name2)
coffee_with_milk2 = MilkDecorator.new(coffee2, client_name2)

puts coffee_with_milk2.description # Виведе: "Кава клієнта Даня, з молоком клієнта Даня"
puts coffee_with_milk2.cost        # Виведе: 18.0
