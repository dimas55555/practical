class DivisionBySixError < StandardError
  def initialize(message = "Ділення на 6 неможливе!")
    super(message)
  end
end

begin
  # Перевіряємо ділення на 6
  number = 16
  if number % 6 != 0
    raise DivisionBySixError.new("Ділення на 6 неможливе!")
  end
  result = 16 / 6
rescue ZeroDivisionError
  puts "Ділення на нуль неможливе!"
rescue DivisionBySixError => e
  puts "Помилка: #{e.message}"
else
  puts "Операція виконана успішно: #{result}"
ensure
  puts "Цей блок виконається завжди"
end
