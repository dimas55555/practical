# main.rb
require_relative 'game_scenario_dsl'
require 'io/console'
def clear_screen
  Gem.win_platform? ? system('cls') : system('clear')
end

RACES = %w[Human Elf Dwarf Orc] # Замініть це на свій список рас
CLASSES = %w[Warrior Mage Rogue Cleric] # Замініть це на свій список класів

def choose_race
  puts "Доступні раси:"
  RACES.each_with_index { |race, index| puts "#{index + 1}. #{race}" }
  print "Оберіть номер раси: "
  chosen_index = gets.chomp.to_i - 1
  RACES[chosen_index] if chosen_index.between?(0, RACES.size - 1)
end

def choose_class
  puts "Доступні класи:"
  CLASSES.each_with_index { |class_type, index| puts "#{index + 1}. #{class_type}" }
  print "Оберіть номер класу: "
  chosen_index = gets.chomp.to_i - 1
  CLASSES[chosen_index] if chosen_index.between?(0, CLASSES.size - 1)
end

dnd_player = DnDDSL.new

# Генерація початкової локації
initial_location_name = "Початкова локація"
initial_location_description = "Локація, з якої гравець розпочинає свою подорож."

initial_location = Location.new(initial_location_name)
initial_location.description(initial_location_description)
dnd_player.add_location(initial_location_name) { description initial_location_description }

loop do
  puts "===== DnD Player Menu ====="
  puts "1. Дії з персонажами"
  puts "2. Дії з локаціями"
  puts "3. Події"
  puts "4. Вихід"

  choice = gets.chomp.to_i
  case choice
  when 1
    loop do
      puts "===== Дії з персонажами ====="
      puts "1. Додати персонажа"
      puts "2. Переглянути список персонажів"
      puts "0. Повернутися до головного меню"

      sub_choice = gets.chomp.to_i

      case sub_choice
      when 1
        puts "===== Додати персонажа ====="
        print "Ім'я персонажа: "
        name = gets.chomp
        race = choose_race
        class_type = choose_class

        if race && class_type
          dnd_player.add_character(name) do
            race race
            class_type class_type
            print "Рівень: "
            level gets.chomp.to_i
            print "Екіпірування (розділіть предмети комами): "
            equipment gets.chomp.split(", ")
          end
          puts "Персонаж #{name} успішно доданий!\n\n"
        else
          puts "Невірний вибір раси або класу. Спробуйте ще раз."
        end
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
            # Знаходження локації, до якої відноситься персонаж
            location = dnd_player.locations.find { |loc| loc[:characters].include?(character) }

            if location
              puts "Локація: #{location[:name]}"
            else
              puts "Персонаж не знаходиться в жодній локації"
            end
          end
        end
        puts "\n"
      when 0
        break
      else
        puts "Невірний вибір. Спробуйте ще раз."
      end
    end

  when 2
    loop do
      puts "===== Дії з локаціями ====="
      puts "1. Додати локацію"
      puts "2. Переглянути список локацій"
      puts "3. Додати монстра"
      puts "4. Список монстрів"
      puts "0. Повернутися до головного меню"

      sub_choice = gets.chomp.to_i

      case sub_choice
      when 1
        puts "===== Додати локацію ====="
        print "Назва локації: "
        location_name = gets.chomp
        dnd_player.add_location(location_name) do
          print "Опис локації: "
          description gets.chomp
        end
        puts "Локація #{location_name} успішно додана!\n\n"
      when 2
        puts "===== Переглянути список локацій ====="
        if dnd_player.locations.empty?
          puts "Немає доданих локацій."
        else
          dnd_player.locations.each_with_index do |location, index|
            puts "#{index + 1}. #{location[:name]}"
            puts "Опис: #{location[:description]}"

            if location[:monsters].empty?
              puts "На локації немає монстрів."
            else
              puts "Монстри на локації:"
              location[:monsters].each do |monster|
                if monster[:race] # Якщо монстр має поле :race, то це гуманоїдний монстр
                  puts "Назва: #{monster[:name]}"
                  puts "Раса: #{monster[:race]}"
                  puts "Клас: #{monster[:class]}"
                else
                  puts "Назва: #{monster[:name]}"
                  puts "Тип: #{monster[:monster_type]}"
                end
                puts "-----"
              end
            end

            puts "========================="
          end
        end
        puts "\n"
      when 3
        loop do
          puts "===== Додати монстра ====="
          puts "1. Додати гуманоїдного монстра"
          puts "2. Додати монстра"
          puts "3. Додати монстра на локацію"
          puts "0. Назад"

          sub_choice_monster = gets.chomp.to_i

          case sub_choice_monster
          when 1
            puts "===== Додати гуманоїдного монстра ====="
            print "Ім'я монстра: "
            name = gets.chomp
            race = choose_race
            class_type = choose_class
            if race && class_type
              dnd_player.add_humanoid_monster(name) do
                race race
                class_type class_type
                print "Рівень: "
                level gets.chomp.to_i
              end
              puts "Гуманоїдний монстр #{name} успішно доданий!\n\n"
            else
              puts "Невірний вибір раси або класу для гуманоїдного монстра. Спробуйте ще раз."
            end
          when 2
            puts "===== Додати монстра ====="
            print "Назва: "
            monster_name = gets.chomp
            dnd_player.add_regular_monster(monster_name) do
              print "Тип: "
              monster_type gets.chomp
              print "Рівень: "
              level gets.chomp.to_i
            end
            puts "Монстр #{monster_name} успішно доданий!\n\n"
          when 3
            puts "===== Додати монстра на локацію ====="
            if dnd_player.locations.empty?
              puts "Немає доданих локацій. Спочатку додайте локації."
            else
              puts "Доступні локації:"
              dnd_player.locations.each_with_index do |location, index|
                puts "#{index + 1}. #{location[:name]}"
              end
              print "Оберіть номер локації, на яку додати монстра: "
              location_index = gets.chomp.to_i - 1

              if location_index.between?(0, dnd_player.locations.size - 1)
                location = dnd_player.locations[location_index]

                puts "Доступні монстри:"
                puts "1. Гуманоїдний монстр"
                puts "2. Звичайний монстр"
                monster_type = gets.chomp.to_i

                case monster_type
                when 1
                  puts "Доступні гуманоїдні монстри:"
                  dnd_player.humanoid_monsters.each_with_index do |monster, index|
                    puts "#{index + 1}. #{monster[:name]}"
                  end
                  print "Оберіть номер гуманоїдного монстра: "
                  humanoid_monster_index = gets.chomp.to_i - 1

                  if humanoid_monster_index.between?(0, dnd_player.humanoid_monsters.size - 1)
                    humanoid_monster = dnd_player.humanoid_monsters[humanoid_monster_index]
                    location[:monsters] << humanoid_monster # Виправлено тут
                    puts "Гуманоїдний монстр #{humanoid_monster[:name]} успішно доданий до локації #{location[:name]}!\n\n"
                  else
                    puts "Невірний номер гуманоїдного монстра. Спробуйте ще раз."
                  end
                when 2
                  puts "Доступні звичайні монстри:"
                  dnd_player.regular_monsters.each_with_index do |monster, index|
                    puts "#{index + 1}. #{monster[:name]}"
                  end
                  print "Оберіть номер звичайного монстра: "
                  regular_monster_index = gets.chomp.to_i - 1

                  if regular_monster_index.between?(0, dnd_player.regular_monsters.size - 1)
                    regular_monster = dnd_player.regular_monsters[regular_monster_index]
                    location[:monsters] << regular_monster # Виправлено тут
                    puts "Звичайний монстр #{regular_monster[:name]} успішно доданий до локації #{location[:name]}!\n\n"
                  else
                    puts "Невірний номер звичайного монстра. Спробуйте ще раз."
                  end
                else
                  puts "Невірний вибір. Спробуйте ще раз."
                end
              else
                puts "Невірний номер локації. Спробуйте ще раз."
              end
            end
          when 0
            break
          else
            puts "Невірний вибір. Спробуйте ще раз."
          end
        end
      when 4
        puts "===== Список монстрів ====="
        if dnd_player.regular_monsters.empty? && dnd_player.humanoid_monsters.empty?
          puts "Немає доданих монстрів."
        else
          puts "Звичайні монстри:"
          dnd_player.regular_monsters.each do |monster|
            puts "\nНазва: #{monster[:name]}"
            puts "Тип: #{monster[:monster_type]}"
            puts "Рівень: #{monster[:level]}"
          end

          puts "\nГуманоїдні монстри:"
          dnd_player.humanoid_monsters.each do |monster|
            puts "\nНазва: #{monster[:name]}"
            puts "Раса: #{monster[:race]}"
            puts "Клас: #{monster[:class]}"
            puts "Рівень: #{monster[:level]}"
          end
        end
        puts "\n"
      when 0
        break
      else
        puts "Невірний вибір. Спробуйте ще раз."
      end
    end

  when 3
    loop do
      puts "===== Події ====="
      puts "1. Перемістити персонажа"
      puts "2. Випадкова зустріч"
      puts "3. Прибрати персонажа з локації"
      puts "0. Повернутися до головного меню"

      sub_choice = gets.chomp.to_i

      case sub_choice
      when 1
        # Логіка для переміщення персонажа
      when 2
        # Логіка для випадкової зустрічі
      when 3
        # Логіка для видалення персонажа з локації
      when 0
        break
      else
        puts "Невірний вибір. Спробуйте ще раз."
      end
    end

  when 4
    break
  else
    puts "Невірний вибір. Спробуйте ще раз."
  end
end
