# game_scenario_dsl.rb
require_relative 'player'
require_relative 'npc'
require_relative 'inventory'
class GameScenario
  attr_accessor :player, :npcs

  def initialize(&block)
    @player = Player.new
    @npcs = []
    instance_eval(&block) if block_given?
  end

  def player_name(name)
    @player.name = name
  end

  def player_class(character_class)
    @player.character_class = character_class
  end

  def player_health(health)
    @player.health = health
  end

  def player_inventory(&block)
    @player.inventory = Inventory.new(&block)
  end

  def add_npc(name, &block)
    npc = NPC.new(name)
    npc.instance_eval(&block) if block_given?
    @npcs << npc
  end

  def player_action(&block)
    @player.instance_eval(&block) if block_given?
  end

  def run
    puts "Game scenario is starting..."
    puts "Player: #{@player}"
    @npcs.each { |npc| puts "NPC: #{npc}" }
    @player.perform_actions
    puts "Game scenario is complete."
  end
end

# ... (решта коду)
