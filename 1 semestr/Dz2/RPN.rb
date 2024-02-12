# функція для перетворення виразу на запис RPN
def infix_to_rpn(expression)
  # оператори та їхні пріоритети
  precedence = { '+' => 1, '-' => 1, '*' => 2, '/' => 2, '^' => 3 }
  # вихідний масив для RPN виразу
  output = []
  # стек операторів
  stack = []

  # розбиваємо вхідний вираз на числа, оператори та дужки (назвемо іх токени)
  tokens = expression.scan(/\d+|\+|-|\*|\/|\^|\(|\)/)

  # проводимо їх обробку
  tokens.each do |token|
    if token.match(/\d+/)
      # якщо число, то додаємо його у вихід
      output << token
    elsif token == '('
      # якщо дужка, що відкриває, поміщаємо її в стек
      stack << token
    elsif token == ')'
      # якщо дужка, що закриває, виштовхуємо оператори зі стека
      # у вихід, поки не зустрінемо дужку, що відкриває
      while stack.last != '('
        output << stack.pop
      end
      # видаляємо дужку, що відкриває, зі стека
      stack.pop if stack.last == '('
    else
      # якщо оператор, обробляємо його пріоритет
      while !stack.empty? && precedence[token] <= (precedence[stack.last] || 0)
        # поміщаємо поточний оператор у стек
        output << stack.pop
      end
      stack << token
    end
  end

  # додаємо оператори, що залишилися, зі стека у вихід
  while !stack.empty?
    output << stack.pop
  end

  # повертаємо RPN вираз у вигляді рядка, об'єднуючи елементи через пропуск
  return output.join(' ')
end

# запуск нескінченному циклі
loop do
  # отримання виразу
  print " Enter the mathematical expression in the usual form: "
  infix_expression = gets.chomp
  rpn_expression = infix_to_rpn(infix_expression)
  puts "The result is in RPN format: #{rpn_expression}"

  puts " Do you want to enter another expression? (yes/no)"
  play_again = gets.chomp.downcase
  # якщо відповідь не "yes", виходимо із циклу
  break if play_again != "yes"
end