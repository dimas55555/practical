def generate_random_password(length)
  characters = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a
  password = Array.new(length) { characters.sample }
  password.join
end

loop do
  puts "1. Згенерувати випадковий пароль"
  puts "0. Вийти"
  print "Виберіть опцію: "
  choice = gets.chomp.to_i

  case choice
  when 1
    print "Введіть бажану довжину пароля: "
    length = gets.chomp.to_i

    if length <= 0
      puts "Довжина пароля повинна бути додатнім числом."
    else
      random_password = generate_random_password(length)
      puts "Згенерований випадковий пароль: #{random_password}"
    end
  when 0
    puts "До побачення!"
    break
  else
    puts "Невірний вибір. Виберіть 1 чи 0"
  end
end
