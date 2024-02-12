# функцію, яка вибирає випадково один з трьох варіантів: камінь, ножиці або папір.
def get_computer_choice
  choices = %w[rock scissors paper]
  computer_choice = choices.sample
  return computer_choice
end

# функцію, що приймає вибір гравця і комп'ютера і визначає переможця, або нічию
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

# запуск гри в нескінченному циклі
loop do
  puts "Choose a move (rock, scissors, paper):"
  player_choice = gets.chomp.downcase

  # перевірка, чи гравець ввів правильний вибір
  unless %w[rock scissors paper].include?(player_choice)
    puts "Please select one of the options: rock, scissors or paper."
    next
  end

  # отримуємо вибір комп'ютера
  computer_choice = get_computer_choice

  puts "You chose: #{player_choice}"
  puts "The computer chose: #{computer_choice}"

  # визначення переможця за допомогою функції determine_winner
  winner = determine_winner(player_choice, computer_choice)
  # вивід результату
  puts winner

  puts "Do you want to play again? (yes/no)"
  play_again = gets.chomp.downcase
  # якщо відповідь не "yes", виходимо із циклу
  break if play_again != "yes"
end

puts "Thanks for the game!"
