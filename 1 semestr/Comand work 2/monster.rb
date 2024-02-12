class RegularMonster
  def initialize(name)
    @details = { name: name }
  end

  def monster_type(monster_type)
    @details[:monster_type] = monster_type
  end

  def strength(strength)
    @details[:strength] = strength
  end

  def dexterity(dexterity)
    @details[:dexterity] = dexterity
  end

  def constitution(constitution)
    @details[:constitution] = constitution
  end

  def intelligence(intelligence)
    @details[:intelligence] = intelligence
  end

  def hp(hp)
    @details[:hp] = hp
  end

  def details
    @details
  end
end
