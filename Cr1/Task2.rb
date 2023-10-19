module MathOperations
  def add(a, b)
    a + b
  end

  def subtract(a, b)
    a - b
  end
end

class Calculator
  include MathOperations
end

calc = Calculator.new
puts calc.add(5, 5)
puts calc.subtract(12, 4)
