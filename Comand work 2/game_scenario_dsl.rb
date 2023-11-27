# game_scenario_dsl.rb
require_relative 'player'
require_relative 'location'
require_relative 'humanmonster'
require_relative 'monster'
class DnDDSL
  attr_reader :player, :locations, :humanoid_monsters, :regular_monsters

  def initialize
    @player = { characters: [] }
    @locations = []
    @humanoid_monsters = []
    @regular_monsters = []
  end

  def title(name)
    @player[:title] = name
  end

  def introduction(text)
    @player[:introduction] = text
  end

  def add_character(name, &block)
    character = Character.new(name)
    character.instance_eval(&block)
    @player[:characters] << character.details
    # Додати нового персонажа в початкову локацію
    initial_location = @locations.find { |location| location[:name] == "Початкова локація" }
    initial_location[:characters] << character.details
  end

  def add_location(name, &block)
    location = Location.new(name)
    location.instance_eval(&block)
    @locations << location.details
  end

  def add_humanoid_monster(name, &block)
    humanoid_monster = HumanoidMonster.new(name)
    humanoid_monster.instance_eval(&block)
    @humanoid_monsters << humanoid_monster.details
  end

  def add_regular_monster(name, &block)
    regular_monster = RegularMonster.new(name)
    regular_monster.instance_eval(&block)
    @regular_monsters << regular_monster.details
  end
end
