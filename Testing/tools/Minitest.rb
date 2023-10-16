# test_example.rb
require 'minitest/autorun'

class TestExample < Minitest::Test
  def test_addition
    result = 1 + 1
    assert_equal(2, result)
    puts "Тест додавання успішно пройдений!"
  end

  def test_subtraction
    result = 3 - 1
    assert_equal(2, result)
    puts "Тест віднімання успішно пройдений!"
  end

  def test_multiplication
    result = 2 * 3
    assert_equal(6, result)
    puts "Тест множення успішно пройдений!"
  end

  def test_division
    result = 6 / 3
    assert_equal(2, result)
    puts "Тест ділення успішно пройдений!"
  end
end
