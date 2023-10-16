class NegativeNumberError < StandardError
  def initialize(message = "Число не може бути від'ємним.")
    super(message)
  end
end

def calculate_square_root(number)
  raise NegativeNumberError if number < 0
  Math.sqrt(number)
end

begin
  print "Введіть число: "
  input = gets.to_i
  result = calculate_square_root(input)
  puts "Квадратний корінь: #{result}"
rescue NegativeNumberError => e
  puts "Помилка: #{e.message}"
end
