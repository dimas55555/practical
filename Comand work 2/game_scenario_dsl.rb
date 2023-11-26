# game_scenario_dsl.rb
require_relative 'player'

class DnDDSL
  attr_reader :player

  def initialize
    @player = { characters: [] }
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
  end
end

