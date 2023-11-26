# main.rb
require_relative 'game_scenario_dsl'
require 'io/console'
def clear_screen
  if Gem.win_platform?
    system('cls')
  else
    system('clear')
  end
end

dnd_player = DnDDSL.new

loop do
  puts "===== DnD Player Menu ====="
  puts "1. Додати персонажа"
  puts "2. Перегляд персонажів"
  puts "3. Вийти"

  choice = gets.chomp.to_i

  case choice
  when 1
    clear_screen # очищення консолі
    puts "===== Додати персонажа ====="
    print "Ім'я персонажа: "
    name = gets.chomp
    dnd_player.add_character(name) do
      print "Раса: "
      race gets.chomp
      print "Клас: "
      class_type gets.chomp
      print "Рівень: "
      level gets.chomp.to_i
      print "Екіпірування (розділіть предмети комами): "
      equipment gets.chomp.split(", ")
    end
    puts "Персонаж #{name} успішно доданий!\n\n"
  when 2
    puts "===== Перегляд персонажів ====="
    if dnd_player.player[:characters].empty?
      puts "Немає доданих персонажів."
    else
      dnd_player.player[:characters].each do |character|
        puts "\nІм'я: #{character[:name]}"
        puts "Раса: #{character[:race]}"
        puts "Клас: #{character[:class]}"
        puts "Рівень: #{character[:level]}"
        puts "Екіпірування: #{character[:equipment].join(", ")}"
      end
    end
    puts "\n"
  when 3
    break
  else
    puts "Невірний вибір. Спробуйте ще раз."
  end
end
