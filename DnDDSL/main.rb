require_relative 'dnd_scenario'
# require_relative 'action'
scenario = Dnd_scenario.new
location = Location.new("Ліс")
scenario.add_location(location)

location = Location.new("Підземелля")
scenario.add_location(location)
scenario.print_locations_list
character = Character.build("Гатс") do
  set_race "Людина"
  set_class_type "Воїн"
  set_abilities do
    strength 20
    dexterity 15
    constitution 17
    intelligence 17
    charisma 20
  end
  set_health 200
end
scenario.add_character(character)

character = Character.build("Аста") do
  set_race "Людина"
  set_class_type "Воїн"
  set_abilities do
    strength 15
    dexterity 14
    constitution 17
    intelligence 6
    charisma 12
  end
  set_health 150
end
scenario.add_character(character)


monster = Monster.build("Вікінг") do
  set_health 150
  set_abilities do
    strength 16
    dexterity 15
    constitution 17
    intelligence 10
    charisma 13
  end
end
scenario.locations[0].add_monster(monster)

monster = Monster.build("Демон") do
  set_health 300
  set_abilities do
    strength 19
    dexterity 18
    constitution 16
    intelligence 19
    charisma 12
  end
end
scenario.locations[1].add_monster(monster)

Action.move_character_to_location(scenario.players[0], scenario.locations[0])
Action.move_character_to_location(scenario.players[1], scenario.locations[1])

scenario.print_players_list
scenario.print_locations_list

Action.show_characters_on_location(scenario.locations[0])
puts
Action.show_monsters_on_location(scenario.locations[0])
puts
event = Action.character_meet_enemy(scenario.players[0], scenario.locations[0])
puts
Action.fight(event[0], event[1])
puts
Action.show_monsters_on_location(scenario.locations[0])
Action.remove_character_from_location(scenario.players[0], scenario.locations[0])

Action.show_characters_on_location(scenario.locations[1])
puts
Action.show_monsters_on_location(scenario.locations[1])
puts
event = Action.character_meet_enemy(scenario.players[1], scenario.locations[1])
puts
Action.character_run_away_from_fight(event[0], event[1])
puts
Action.show_monsters_on_location(scenario.locations[0])

scenario.print_players_list
scenario.print_locations_list