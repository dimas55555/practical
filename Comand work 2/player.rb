# player.rb
class Player
  attr_accessor :name, :character_class, :health, :actions, :inventory

  def initialize
    @actions = []
  end

  def perform_actions
    puts "Player is taking actions:"
    @actions.each { |action| puts "- #{action}" }
  end

  def player_action(&block)
    instance_eval(&block) if block_given?
  end

  def to_s
    "#{name}, Class: #{character_class}, Health: #{health}, Inventory: #{inventory}"
  end
end

