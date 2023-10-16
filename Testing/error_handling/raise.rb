begin
  # Ваш код, який може викликати помилку
  age = -1
  if age < 0
    raise ArgumentError, "Вік не може бути від'ємним"
  end
rescue ArgumentError => e
  puts "Помилка: #{e.message}"
end