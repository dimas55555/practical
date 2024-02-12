# frozen_string_literal: true

class Character
  attr_accessor :name, :race, :class_type, :abilities, :health, :location

  def initialize(name)
    @details = { name: name, abilities: {}}
    @location = nil
  end
  def set_location(location)
    @location = location
  end
  def set_race(race)
    @details[:race] = race
  end

  def set_class_type(class_type)
    @details[:class] = class_type
  end

  def set_abilities(&block)
    instance_eval(&block) if block_given?
  end

  def strength(value)
    @details[:abilities][:strength] = value
  end

  def dexterity(value)
    @details[:abilities][:dexterity] = value
  end

  def constitution(value)
    @details[:abilities][:constitution] = value
  end

  def intelligence(value)
    @details[:abilities][:intelligence] = value
  end

  def charisma(value)
    @details[:abilities][:charisma] = value
  end

  def set_health(health)
    @details[:health] = health
  end

  def details
    @details
  end
  def get_ability(ability_name)
    @details[:abilities][ability_name.to_sym]
  end
  def is_alive?
    details[:health] > 0
  end

  def check_abilities_modifier(ability_name)
    ability_score = get_ability(ability_name)
    modifier = (ability_score - 10) / 2
    modifier.floor
  end

  def self.build(name, &block)
    character = new(name)
    character.instance_eval(&block) if block_given?
    character
  end
end

