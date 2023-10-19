numbers = []

loop do
  puts "1. Ввести нові числа"
  puts "2. Сортувати у порядку зростання"
  puts "3. Сортувати у порядку спадання"
  puts "0. Вийти"
  print "Виберіть опцію: "
  choice = gets.chomp.to_i

  case choice
  when 1
    print "Введіть числа через кому: "
    input = gets.chomp
    numbers = input.split(",").map(&:to_i)
  when 2
    sorted_numbers = numbers.sort
    puts "Відсортований список: #{sorted_numbers.join(", ")}"
  when 3
    sorted_numbers = numbers.sort.reverse
    puts "Відсортований список: #{sorted_numbers.join(", ")}"
  when 0
    puts "До побачення!"
    break
  else
    puts "Невірний вибір. Виберіть 1, 2, 3 чи 0"
  end
end
