class Location
  def initialize(name)
    @details = { name: name, monsters: [], characters: [] }
  end

  def description(description)
    @details[:description] = description
  end

  def add_monster(monster)
    @details[:monsters] << monster
  end

  def add_character(character)
    @details[:characters] << character
  end

  def details
    @details
  end
end