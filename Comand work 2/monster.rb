class RegularMonster
  def initialize(name)
    @details = { name: name }
  end

  def monster_type(monster_type)
    @details[:monster_type] = monster_type
  end

  def level(level)
    @details[:level] = level
  end

  def details
    @details
  end
end