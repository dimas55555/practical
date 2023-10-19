class Stab
  def initialize(value)
    @value = value
  end

  def get_value
    @value
  end

  def set_value(new_value)
    @value = new_value
  end
end

# Створюємо новий екземпляр стабу зі значенням 10
stab_instance = Stab.new(10)

# Отримуємо значення зі стабу
puts "Початкове значення стабу: #{stab_instance.get_value}"

# Змінюємо значення в стабі
stab_instance.set_value(20)

# Отримуємо нове значення зі стабу
puts "Нове значення стабу: #{stab_instance.get_value}"
