# npc.rb
class NPC
  attr_accessor :name, :dialogue

  def initialize(name)
    @name = name
    @dialogue = ""
  end

  def add_dialogue(dialogue)
    @dialogue = dialogue
  end

  def to_s
    "#{name}, Dialogue: #{@dialogue}"
  end
end
