require_relative 'character'
require_relative 'location'
require_relative 'monster'
require_relative 'action'

class Dnd_scenario
    attr_reader :players, :locations

    def initialize
      @players =  []
      @locations = []
    end

    def add_character(character)
      @players << character

    end

    def add_location(location)
      @locations << location
    end

    def add_monster(monster)
      @monsters << monster
    end

    def print_players_list
      puts "\n----- Список гравців ------"
      players.each do |character|
        puts "Ім'я: #{character.details[:name]},
        Раса: #{character.details[:race]},
        Клас: #{character.details[:class]},
        Здоров'я: #{character.details[:health]}"
        if character.is_alive?
          if character.location.nil?
            puts "Місцезнаходження: в дорозі"
          else
            puts"Місцезнаходження: #{character.location.details[:name]} "
          end
        else
          puts "Місцезнаходження: на небі"
        end

        puts "------------------------"
      end
      puts
    end
    def print_locations_list
      puts "\n----- Список локацій ------"
      locations.each do |location|
        puts "Ім'я: #{location.details[:name]}"
        Action.show_monsters_on_location(location)
        puts "------------------------"
      end
      puts
    end
end