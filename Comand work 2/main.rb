# main.rb
require_relative 'game_scenario_dsl'
require 'io/console'
def clear_screen
  Gem.win_platform? ? system('cls') : system('clear')
end

RACES = %w[Human Elf Dwarf Orc] # свій список рас
CLASSES = %w[Warrior Mage Rogue Cleric] # свій список класів

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

def roll_dice(sides)
  rand(1..sides)
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

        bonus_dexterity = 0
        bonus_constitution = 0
        bonus_strength = 0
        bonus_intelligence = 0
        bonus_HP = 0

        if race && class_type
          puts "Оберіть початкові характеристики для персонажа #{name}:"

          case race
          when 'Dwarf'
            bonus_constitution = 2
            bonus_strength = 1
          when 'Orc'
            bonus_strength = 2
            bonus_constitution = 1
          when 'Elf'
            bonus_dexterity = 2
            bonus_intelligence = 1
          when 'Human'
            bonus_intelligence = 2
            bonus_dexterity = 1
          else
            bonus_constitution = 0
            bonus_strength = 0
            bonus_dexterity = 0
            bonus_intelligence = 0
          end

          case class_type
          when 'Warrior'
            bonus_strength +=6
            bonus_HP += 12
          when 'Mage', 'Cleric'
            bonus_intelligence += 6
            bonus_HP += 6
          when 'Rogue'
            bonus_dexterity +=6
            bonus_HP += 8
          else
            puts "Невідомий клас персонажа. Спробуйте ще раз."
            return
          end

          strength = roll_dice(6) + roll_dice(6) +  roll_dice(6) + bonus_strength
          dexterity = roll_dice(6) + roll_dice(6) + roll_dice(6) + bonus_dexterity
          constitution = roll_dice(6) + roll_dice(6) + roll_dice(6) + bonus_constitution
          intelligence = roll_dice(6) + 6 + roll_dice(6) + roll_dice(6) + bonus_intelligence
          hp = roll_dice(6) + roll_dice(6) + roll_dice(6) + bonus_HP

          puts "Ваша сила: #{strength}"
          puts "Ваша спритність: #{dexterity}"
          puts "Ваша витривалість: #{constitution}"
          puts "Ваш інтелект: #{intelligence}"
          puts "Ваші HP: #{hp}"

          dnd_player.add_character(name) do
            race race
            class_type class_type
            strength strength
            dexterity dexterity
            constitution constitution
            intelligence intelligence
            hp hp
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
            puts "Сила: #{character[:strength]}"
            puts "Спритність: #{character[:dexterity]}"
            puts "Витривалість: #{character[:constitution]}"
            puts "Інтелект: #{character[:intelligence]}"
            puts "HP: #{character[:hp]}"

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
              puts "Оберіть початкові характеристики для гуманоїдного монстра #{name}:"

              bonus_dexterity = 0
              bonus_constitution = 0
              bonus_strength = 0
              bonus_intelligence = 0
              bonus_HP = 0

              case race
              when 'Dwarf'
                bonus_constitution = 2
                bonus_strength = 1
              when 'Orc'
                bonus_strength = 2
                bonus_constitution = 1
              when 'Elf'
                bonus_dexterity = 2
                bonus_intelligence = 1
              when 'Human'
                bonus_intelligence = 2
                bonus_dexterity = 1
              else
                bonus_constitution = 0
                bonus_strength = 0
                bonus_dexterity = 0
                bonus_intelligence = 0
              end

              case class_type
              when 'Warrior'
                bonus_strength += 6
                bonus_HP += 12
              when 'Mage', 'Cleric'
                bonus_intelligence += 6
                bonus_HP += 6
              when 'Rogue'
                bonus_dexterity += 6
                bonus_HP += 8
              else
                puts "Невідомий клас гуманоїдного монстра. Спробуйте ще раз."
                return
              end

              strength = roll_dice(6) + roll_dice(6) + roll_dice(6) + bonus_strength
              dexterity = roll_dice(6) + roll_dice(6) + roll_dice(6) + bonus_dexterity
              constitution = roll_dice(6) + roll_dice(6) + roll_dice(6) + bonus_constitution
              intelligence = roll_dice(6) + 6 + roll_dice(6) + roll_dice(6) + bonus_intelligence
              hp = roll_dice(6) + roll_dice(6) + roll_dice(6) + bonus_HP

              puts "Сила: #{strength}"
              puts "Спритність: #{dexterity}"
              puts "Витривалість: #{constitution}"
              puts "Інтелект: #{intelligence}"
              puts "HP: #{hp}"

              dnd_player.add_humanoid_monster(name) do
                race race
                class_type class_type
                strength strength
                dexterity dexterity
                constitution constitution
                intelligence intelligence
                hp hp
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

              print "Сила: "
              strength gets.chomp.to_i

              print "Спритність: "
              dexterity gets.chomp.to_i

              print "Витривалість: "
              constitution gets.chomp.to_i

              print "Інтелект: "
              intelligence gets.chomp.to_i

              print "HP: "
              hp gets.chomp.to_i
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

            # Знаходження локації, до якої відноситься монстр
            locations = dnd_player.locations.select { |loc| loc[:monsters].include?(monster) }
            puts "Локації: #{locations.map { |loc| loc[:name] }.join(", ")}" unless locations.empty?
          end

          puts "\nГуманоїдні монстри:"
          dnd_player.humanoid_monsters.each do |humanmonster|
            puts "\nНазва: #{humanmonster[:name]}"
            puts "Раса: #{humanmonster[:race]}"
            puts "Клас: #{humanmonster[:class]}"

            # Знаходження локації, до якої відноситься монстр
            locations = dnd_player.locations.select { |loc| loc[:monsters].include?(humanmonster) }
            puts "Локації: #{locations.map { |loc| loc[:name] }.join(", ")}" unless locations.empty?
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
      puts "1. Перемістити персонажа на локацію"
      puts "2. Випадкова зустріч"
      puts "3. Покинути локацію персонажем"
      puts "0. Повернутися до головного меню"

      sub_choice = gets.chomp.to_i

      case sub_choice
      when 1
        puts "Оберіть персонажа, якого ви хочете перемістити:"
        dnd_player.player[:characters].each_with_index do |character, index|
          puts "#{index + 1}. #{character[:name]}"
        end

        character_choice = gets.chomp.to_i

        if character_choice.positive? && character_choice <= dnd_player.player[:characters].size
          selected_character = dnd_player.player[:characters][character_choice - 1]

          puts "Оберіть локацію, на яку ви хочете перемістити персонажа:"
          dnd_player.locations.each_with_index do |location, index|
            puts "#{index + 1}. #{location[:name]}"
          end

          location_choice = gets.chomp.to_i

          if location_choice.positive? && location_choice <= dnd_player.locations.size
            target_location = dnd_player.locations[location_choice - 1]

            # Перевіряємо, чи персонаж вже наявний на інших локаціях
            existing_location = dnd_player.locations.find { |loc| loc[:characters].include?(selected_character) }

            if existing_location
              # Персонаж вже на інших локаціях, переміщуємо його на нову локацію
              existing_location[:characters].reject! { |char| char[:name] == selected_character[:name] }
              target_location[:characters] << selected_character
            else
              # Персонаж не на локації, додається на обрану локацію
              target_location[:characters] << selected_character
            end

            puts "Персонаж #{selected_character[:name]} успішно переміщений на локацію #{target_location[:name]}!\n\n"
          else
            puts "Невірний вибір локації. Спробуйте ще раз."
          end
        else
          puts "Невірний вибір персонажа. Спробуйте ще раз."
        end
      when 2
        puts "Оберіть персонажа для випадкової зустрічі:"
        dnd_player.player[:characters].each_with_index do |character, index|
          puts "#{index + 1}. #{character[:name]}"
        end

        character_choice = gets.chomp.to_i

        if character_choice.positive? && character_choice <= dnd_player.player[:characters].size
          selected_character = dnd_player.player[:characters][character_choice - 1]

          # Знаходження локації, до якої відноситься персонаж
          location = dnd_player.locations.find { |loc| loc[:characters].include?(selected_character) }

          if location
            # Знаходження монстрів на локації
            available_monsters = dnd_player.humanoid_monsters.select { |monster| location[:monsters].include?(monster) }
            available_monsters += dnd_player.regular_monsters.select { |monster| location[:monsters].include?(monster) }

            if available_monsters.empty?
              puts "На даній локації немає монстрів для зустрічі\n\n"
            else
              # Вибір випадкового монстра
              random_monster = available_monsters.sample

              puts "Персонаж #{selected_character[:name]} зустрів монстра #{random_monster[:name]}!"
              # Додавання зустріченого монстра до локації (можна зробити також інші дії)
              

              puts "\n"
            end
          else
            puts "Персонаж не знаходиться на жодній локації. Спочатку перемістіть його на локацію.\n\n"
          end
        else
          puts "Невірний вибір персонажа. Спробуйте ще раз."
        end
      when 3
        puts "Оберіть персонажа, який повинен покинути локацію:"
        dnd_player.player[:characters].each_with_index do |character, index|
          puts "#{index + 1}. #{character[:name]}"
        end

        character_choice = gets.chomp.to_i

        if character_choice.positive? && character_choice <= dnd_player.player[:characters].size
          selected_character = dnd_player.player[:characters][character_choice - 1]

          # Знаходимо локацію, на якій знаходиться персонаж
          current_location = dnd_player.locations.find { |loc| loc[:characters].include?(selected_character) }

          if current_location
            # Видаляємо персонажа з поточної локації
            current_location[:characters].delete(selected_character)

            puts "Персонаж #{selected_character[:name]} успішно покинув локацію #{current_location[:name]}!\n\n"
          else
            puts "Помилка: персонаж не знаходиться на жодній локації."
          end
        else
          puts "Невірний вибір персонажа. Спробуйте ще раз."
        end
      when 0
        break
      else
        puts "Невідомий вибір. Спробуйте ще раз."
      end
    end
  when 4
    break
  else
    puts "Невірний вибір. Спробуйте ще раз."
  end
end
