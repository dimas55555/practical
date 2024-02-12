# Компонент - базовий клас для замовлення
class Order
  attr_reader :client_name

  def initialize(client_name)
    @client_name = client_name
  end

  # Повертає опис замовлення
  def description
    "Замовлення клієнта #{@client_name}"
  end

  # Повертає вартість замовлення
  def cost
    0
  end
end

# Конкретний компонент - страва в меню
class Dish < Order
  attr_reader :name, :price

  def initialize(client_name, name, price)
    super(client_name)
    @name = name
    @price = price
  end

  # Повертає розширений опис страви з вказанням клієнта
  def description
    "Страва: #{@name}, Замовлення клієнта #{@client_name}"
  end

  # Повертає вартість страви
  def cost
    @price
  end
end

# Декоратор - базовий клас декоратора для замовлення
class OrderDecorator < Order
  attr_reader :order

  def initialize(order, client_name)
    super(client_name)
    @order = order
  end

  # Повертає опис замовлення, який отриманий від декорованого замовлення
  def description
    @order.description
  end

  # Повертає вартість замовлення, яку отримано від декорованого замовлення
  def cost
    @order.cost
  end
end

# Конкретний декоратор - додавання десерту до замовлення
class DessertDecorator < OrderDecorator
  attr_reader :dessert_name, :dessert_price

  def initialize(order, client_name, dessert_name, dessert_price)
    super(order, client_name)
    @dessert_name = dessert_name
    @dessert_price = dessert_price
  end

  # Повертає розширений опис замовлення з вказанням десерту
  def description
    "#{super}, Десерт: #{@dessert_name}"
  end

  # Повертає вартість замовлення з урахуванням додавання десерту
  def cost
    super + @dessert_price
  end
end

# Конкретний декоратор - додавання напою до замовлення
class BeverageDecorator < OrderDecorator
  attr_reader :beverage_name, :beverage_price

  def initialize(order, client_name, beverage_name, beverage_price)
    super(order, client_name)
    @beverage_name = beverage_name
    @beverage_price = beverage_price
  end

  # Повертає розширений опис замовлення з вказанням напою
  def description
    "#{super}, Напій: #{@beverage_name}"
  end

  # Повертає вартість замовлення з урахуванням додавання напою
  def cost
    super + @beverage_price
  end
end

# Використання
client_name = 'Іван'
order = Dish.new(client_name, 'Стейк', 25)
order_with_beverage = BeverageDecorator.new(order, client_name, 'Кава', 5)
order_with_dessert = DessertDecorator.new(order_with_beverage, client_name, 'Чізкейк', 8)

puts order_with_dessert.description # Виведе: "Страва: Стейк, Напій: Кава, Десерт: Чізкейк, Замовлення клієнта Іван"
puts order_with_dessert.cost        # Виведе: 38

client_name2 = 'Даня'
order2 = Dish.new(client_name2, 'Біфштекс', 35)
order_with_beverage2 = BeverageDecorator.new(order2, client_name2, 'Кола', 2)

puts order_with_beverage2.description # Виведе: "Страва: Біфштекс, Напій: Кола, Замовлення клієнта Даня"
puts order_with_beverage2.cost        # Виведе: 37
