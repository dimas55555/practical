require 'minitest/autorun'
require_relative 'calculator'

class CalculatorTest < Minitest::Test
  def test_addition
    result = Calculator.add(2, 2)
    assert_equal 4, result
    puts "Тест на додавання успішний: 2 + 2 = #{result}"
  end

  def test_subtraction
    result = Calculator.subtract(4, 2)
    assert_equal 2, result
    puts "Тест на віднімання успішний: 4 - 2 = #{result}"
  end

  def test_multiplication
    result = Calculator.multiply(5, 2)
    assert_equal 10, result
    puts "Тест на множення успішний: 5 * 2 = #{result}"
  end

  def test_division
    result = Calculator.divide(9, 3)
    assert_equal 3, result
    puts "Тест на ділення успішний: 9 / 3 = #{result}"
  end
end
