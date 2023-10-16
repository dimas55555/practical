begin
  # Код, який може викликати помилку
  result = 10 / 2
rescue ZeroDivisionError
  puts "Ділення на нуль неможливе."
ensure
  puts "Цей код виконається незалежно від того, чи виникла помилка."
end