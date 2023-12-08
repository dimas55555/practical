def my_method_block
  puts "Початок методу"
  yield if block_given?
  puts "Кінець методу"
end

my_method_block do
  puts "Це блок коду, переданий методу"
end
puts "\n"
def my_method_proc(proc)
  puts "Початок методу"
  proc.call
  puts "Кінець методу"
end

my_proc = Proc.new do
  puts "Це процедура"
end

my_method_proc(my_proc)
puts "\n"

def my_method
  puts "Початок методу"
  yield if block_given?
  puts "Кінець методу"
end

my_method do
  puts "Це блок коду, переданий методу з використанням yield"
end
puts "\n"
def my_method_with_block(&block)
  puts "Початок методу"
  block.call if block
  puts "Кінець методу"
end

my_method_with_block do
  puts "Це інший блок коду, переданий методу з використанням явного параметру"
end
