begin
  # Код, який може викликати помилку
  result = 10 / 0
rescue ZeroDivisionError
  puts "Ділення на нуль неможливе."
end
