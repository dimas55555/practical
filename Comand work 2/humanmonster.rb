class HumanoidMonster
  def initialize(name)
    @details = { name: name }
  end

  def race(race)
    @details[:race] = race
  end

  def class_type(class_type)
    @details[:class] = class_type
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
