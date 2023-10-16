require 'minitest/autorun'
require_relative 'app'

class FunctionalTest < Minitest::Test
  def setup
    @calculator = Calculator.new
  end

  def test_addition
    result = @calculator.add(3, 5)
    assert_equal 8, result
    puts "Тест на додавання успішний: 3 + 5 = #{result}"
  end

  def test_subtraction
    result = @calculator.subtract(10, 4)
    assert_equal 6, result
    puts "Тест на віднімання успішний: 10 - 4 = #{result}"
  end
end
