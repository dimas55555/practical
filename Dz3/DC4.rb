# Базовий клас для напоїв
class Beverage
  def cost
    0
  end

  def description
    "Напій"
  end
end

# Конкретний напій - Кава
class Coffee < Beverage
  def cost
    3
  end

  def description
    "Кава"
  end
end

# Декоратор для додавання молока до напою
class MilkDecorator
  def initialize(beverage)
    @beverage = beverage
  end

  def cost
    @beverage.cost + 1
  end

  def description
    "#{@beverage.description}, з молоком"
  end
end

# Декоратор для додавання цукру до напою
class SugarDecorator
  def initialize(beverage)
    @beverage = beverage
  end

  def cost
    @beverage.cost + 0.5
  end

  def description
    "#{@beverage.description}, з цукром"
  end
end

# Використання
coffee = Coffee.new
coffee_with_milk = MilkDecorator.new(coffee)
coffee_with_milk_and_sugar = SugarDecorator.new(coffee_with_milk)

puts coffee_with_milk_and_sugar.description # Виведе: "Кава, з молоком, з цукром"
puts coffee_with_milk_and_sugar.cost        # Виведе: 4.5
