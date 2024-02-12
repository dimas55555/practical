require 'minitest/autorun'
require 'mocha/minitest'

class ExampleClass
  def do_something
    puts "Реальний метод"
  end
end

class TestExampleClass < Minitest::Test
  def setup
    puts "Початок тесту: #{self.class}##{__method__}"
  end

  def teardown
    puts "Завершення тесту: #{self.class}##{__method__}"
  end

  def test_do_something
    puts "Тестуємо метод do_something"

    example_instance = ExampleClass.new
    example_instance.expects(:do_something).returns("Мокований метод")

    result = example_instance.do_something

    assert_equal "Мокований метод", result
  end
end
