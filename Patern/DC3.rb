# Базовий клас для напоїв
class Beverage
  attr_reader :client_name

  def initialize(client_name)
    @client_name = client_name
  end

  # Повертає вартість напою (за замовчуванням - 0)
  def cost
    0
  end

  # Повертає опис напою з вказанням клієнта
  def description
    "Напій клієнта #{@client_name}"
  end
end

# Конкретний компонент- напій  Кава
class Coffee < Beverage
  # вартість кави
  def cost
    15
  end

  # опис кави з вказанням клієнта
  def description
    "Кава клієнта #{@client_name}"
  end
end

# Декоратор - базовий клас декоратора для замовлення напоїв
class BeverageDecorator < Beverage
  def initialize(beverage)
    super(beverage.client_name)
    @beverage = beverage
  end

  # Повертає вартість замовлення, яку отримано від декорованого замовлення
  def cost
    @beverage.cost
  end

  # Повертає опис замовлення, який отриманий від декорованого замовлення
  def description
    @beverage.description
  end
end

# Конкретний декоратор - Додати молоко до напою
class MilkDecorat < BeverageDecorator
  # Додає вартість молока до вартості напою
  def cost
    @beverage.cost + 3
  end

  # Розширює опис напою, додаючи "з молоком"
  def description
    "#{super}, з молоком"
  end
end

# Конкретний декоратор - Додати цукор до напою
class SugarDecorat < BeverageDecorator
  # Додає вартість цукру до вартості напою
  def cost
    @beverage.cost + 2.5
  end

  # Розширює опис напою, додаючи "з цукром"
  def description
    "#{super}, з цукром"
  end
end

# Використання
client_name = 'Іван'
coffee = Coffee.new(client_name)
coffee_with_milk = MilkDecorat.new(coffee)
coffee_with_milk_and_sugar = SugarDecorat.new(coffee_with_milk)

puts coffee_with_milk_and_sugar.description # Виведе: "Кава клієнта Іван, з молоком, з цукром"
puts coffee_with_milk_and_sugar.cost        # Виведе: 20.5

client_name2 = 'Даня'
coffee2 = Coffee.new(client_name2)
coffee_with_milk2 = MilkDecorat.new(coffee2)

puts coffee_with_milk2.description # Виведе: "Кава клієнта Даня, з молоком"
puts coffee_with_milk2.cost        # Виведе: 18.0

