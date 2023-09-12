def get_computer_choice
  choices = ["rock", "scissors", "paper"]
  computer_choice = choices.sample
  return computer_choice
end

def determine_winner(player_choice, computer_choice)
  if player_choice == computer_choice
    return "Draw!"
  elsif (player_choice == "rock" && computer_choice == "scissors") ||
    (player_choice == "scissors" && computer_choice == "paper") ||
    (player_choice == "paper" && computer_choice == "rock")
    return "You won!"
  else
    return "The computer won!"
  end
end

puts "Welcome to 'Rock, Paper, Scissors'!"

loop do
  puts "Choose a move (rock, scissors, paper):"
  player_choice = gets.chomp.downcase

  unless ["rock", "scissors", "paper"].include?(player_choice)
    puts "Please select one of the options: rock, scissors or paper."
    next
  end

  computer_choice = get_computer_choice

  puts "You chose: #{player_choice}"
  puts "The computer chose: #{computer_choice}"

  winner = determine_winner(player_choice, computer_choice)
  puts winner

  puts "Do you want to play again? (yes/no)"
  play_again = gets.chomp.downcase
  break if play_again != "yes"
end

puts "Thanks for the game!"
