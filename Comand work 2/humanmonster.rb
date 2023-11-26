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

  def level(level)
    @details[:level] = level
  end

  def details
    @details
  end
end