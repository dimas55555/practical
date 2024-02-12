
class Action

  def self.roll_dice(sides = 20)
    rand(1..sides)
  end

  def self.show_characters_on_location(location)
    puts "Персонажі на локації #{location.details[:name]}:"
    location.details[:characters].each { |character| puts "#{character.details[:name]} (Здоров'я: #{character.details[:health]})" }
  end

  def self.show_monsters_on_location(location)
    puts "Монстри на локації #{location.details[name]}"
    location.details[:monsters].each { |monster| puts "#{monster.details[:name]} (Здоров'я: #{monster.details[:health]})" }
  end

  def self.move_character_to_location(character, location)
    puts "#{character.details[:name]} рухається до локації #{location.details[:name]}"
    location.details[:characters] << character
    character.location = location
  end
  def self.character_meet_enemy(character, location)
    monster = nil
    if location.details[:monsters].any?
      monster = location.details[:monsters].sample
      puts "#{character.details[:name]} зустрів монстра #{monster.details[:name]}!"
    end

    return character, monster
  end
  def self.fight(character, monster)
    puts "#{character.details[:name]} вступив у бій з #{monster.details[:name]}!"

    while character.is_alive? and monster.is_alive?
      character_damage = calculate_damage(character, monster)
      monster_damage = calculate_damage(monster, character)

      puts "#{character.details[:name]} наніс #{monster.details[:name]} #{character_damage} пошкоджень!"
      puts "#{monster.details[:name]} наніс #{character.details[:name]} #{monster_damage} пошкоджень!"

      # Оновлення здоров'я персонажа та монстра на основі пошкоджень
      character.details[:health] -= monster_damage
      monster.details[:health] -= character_damage
    end
    # Перевірка, чи живі персонаж і монстр
    unless character.is_alive?
      remove_character_from_location(character, character.location)
      puts "#{character.details[:name]} вмер у бою."
    end

    unless monster.is_alive?
      character.location.details[:monsters].delete(monster)
      puts "#{monster.details[:name]} вбитий."
    end
  end

  def self.calculate_damage(attacker, defender)
    attacker_modifier = attacker.check_abilities_modifier(:strength)
    attacker_roll = roll_dice + attacker_modifier
    defender_modifier = defender.check_abilities_modifier(:constitution)
    defender_roll = roll_dice + defender_modifier
    if attacker_roll >= defender_roll
      damage = roll_dice(6)
    else
      damage = 0
    end
    return damage
  end

  def self.character_run_away_from_fight(character, monster)
    character_escape = roll_dice + character.check_abilities_modifier(:dexterity)
    monster_abilities = roll_dice + monster.check_abilities_modifier(:dexterity)
    if character_escape <= monster_abilities
      damage_to_runner = roll_dice(6)
      puts "#{character.details[:name]} намагався втекти, але монстр #{monster.details[:name]} наздогнав його"
      puts "#{character.details[:name]} втратив #{damage_to_runner} ОЗ"
      character.details[:health] -= damage_to_runner
      self.fight(character, monster)
    else
      puts "#{character.details[:name]} втік від битви з #{monster.details[:name]}"
    end
  end



  def self.remove_character_from_location(character, location)
    if character.is_alive?
      puts "#{character.details[:name]} покидає локацію #{location.details[:name]}"
    else puts "Тіло #{character.details[:name]} знайшли на локації #{location.details[:name]}. RIP"
    end
    location.details[:characters].delete(character)
    character.location = nil

  end
end