# Лямбда-вираз
my_lambda = ->(x, y) do
  puts "Лямбда: #{x} + #{y} = #{x + y}"
  x + y
end

# Блок
def my_method
  yield(2, 3) if block_given?
end

# Виклик лямбди
result_lambda = my_lambda.call(2, 3)
puts "Результат лямбди: #{result_lambda}"
puts "\n"

# Виклик методу з блоком
my_method do |x, y|
  puts "Блок: #{x} + #{y} = #{x + y}"
  puts "Результат Блоку: #{x + y}"
end
