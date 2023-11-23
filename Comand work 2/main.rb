# main.rb
require_relative 'game_scenario_dsl'

game = GameScenario.new do
  player_name "Eowyn"
  player_class "Warrior"
  player_health 100

  player_inventory do
    add_item "Sword"
    add_item "Shield"
  end

  add_npc "Gandalf" do
    add_dialogue "You shall not pass!"
  end

  add_npc "Frodo" do
    add_dialogue "I wish the ring had never come to me."
  end

  player_action do
    actions << "Attack with a sword"
    actions << "Drink health potion"
  end
end

game.run
