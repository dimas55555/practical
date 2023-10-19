begin
  result = 12 / 0
rescue ZeroDivisionError
  puts "Ділення на нуль неможливе!"
rescue StandardError => e
  puts "Помилка: #{e.message}"
else
  puts "Операція виконана успішно: #{result}"
ensure
  puts "Цей блок виконається завжди"
end