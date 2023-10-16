def divide
  attempts = 0
  begin
    print "Введіть чисельник: "
    numerator = gets.to_i
    print "Введіть знаменник: "
    denominator = gets.to_i
    result = numerator / denominator
    puts "Результат: #{result}"
  rescue ZeroDivisionError
    puts "Помилка: ділення на нуль неможливе."
    attempts += 1
    retry if attempts < 3
    puts "Вичерпано спроб!"
  end
end

divide
