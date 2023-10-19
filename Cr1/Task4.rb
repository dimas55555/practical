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
    random_password = generate_random_password(length)
    puts "Згенерований випадковий пароль: #{random_password}"
  when 0
    puts "До побачення!"
    break
  else
    puts "Невірний вибір. Виберіть 1 чи 0"
  end
end
