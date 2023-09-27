# Компонент - базовий клас для замовлення
class Order
  def description
    'Замовлення'
  end

  def cost
    0
  end
end

# Конкретний компонент - страва в меню
class Dish < Order
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  def description
    "Страва: #{@name}"
  end

  def cost
    @price
  end
end

# Декоратор - базовий клас декоратора для замовлення
class OrderDecorator < Order
  attr_reader :order

  def initialize(order)
    @order = order
  end

  def description
    @order.description
  end

  def cost
    @order.cost
  end
end
# Конкретний декоратор - додавання десерту до замовлення
class DessertDecorator < OrderDecorator
  attr_reader :dessert_name, :dessert_price

  def initialize(order, dessert_name, dessert_price)
    super(order)
    @dessert_name = dessert_name
    @dessert_price = dessert_price
  end

  def description
    "#{super}, Десерт: #{@dessert_name}"
  end

  def cost
    super + @dessert_price
  end
end

# Конкретний декоратор - додавання напою до замовлення
class BeverageDecorator < OrderDecorator
  attr_reader :beverage_name, :beverage_price

  def initialize(order, beverage_name, beverage_price)
    super(order)
    @beverage_name = beverage_name
    @beverage_price = beverage_price
  end

  def description
    "#{super}, Напій: #{@beverage_name}"
  end

  def cost
    super + @beverage_price
  end
end

# Використання
order = Dish.new('Стейк', 25)
order_with_beverage = BeverageDecorator.new(order, 'Кава', 5)
order_with_dessert = DessertDecorator.new(order_with_beverage, 'Чізкейк', 8)

puts order_with_dessert.description # Виведе: "Страва: Стейк, Напій: Кава, Десерт: Чізкейк"
puts order_with_dessert.cost        # Виведе: 38