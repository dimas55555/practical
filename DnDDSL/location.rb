# frozen_string_literal: true

class Location
  attr_accessor :name, :characters, :monsters

  def initialize(name)
    @details = {name: name, characters: [], monsters: []}
  end

  def add_character(character)
    @details[:characters] << character
  end
  def add_monster(monster)
    @details[:monsters] << monster
  end
  def details
    @details
  end
  def self.build(name, &block)
    location = new(name)
    location.instance_eval(&block) if block_given?
    location
  end
end
