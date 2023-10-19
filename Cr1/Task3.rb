numbers = []
def bubble_sort_asc(arr)
  n = arr.length
  loop do
    swapped = false
    (n - 1).times do |i|
      if arr[i] > arr[i + 1]
        arr[i], arr[i + 1] = arr[i + 1], arr[i]
        swapped = true
      end
    end
    break unless swapped
  end
  arr
end

def bubble_sort_desc(arr)
  n = arr.length
  loop do
    swapped = false
    (n - 1).times do |i|
      if arr[i] < arr[i + 1]
        arr[i], arr[i + 1] = arr[i + 1], arr[i]
        swapped = true
      end
    end
    break unless swapped
  end
  arr
end

loop do
  puts "1. Ввести нові числа"
  puts "2. Сортувати у порядку зростання"
  puts "3. Сортувати у порядку спадання"
  puts "4. Сортувати за методом 'бульбашки' у порядку зростання"
  puts "5. Сортувати за методом 'бульбашки' у порядку спадання"
  puts "0. Вийти"
  print "Виберіть опцію: "
  choice = gets.chomp.to_i

  case choice
  when 1
    print "Введіть числа через кому: "
    input = gets.chomp
    numbers = input.split(",").map(&:to_i)
  when 2
    sorted_numbers = numbers.sort
    puts "Відсортований список: #{sorted_numbers.join(", ")}"
  when 3
    sorted_numbers = numbers.sort.reverse
    puts "Відсортований список: #{sorted_numbers.join(", ")}"
  when 4
    sorted_numbers = bubble_sort_asc(numbers.dup)
    puts "Відсортований список за методом 'бульбашки': #{sorted_numbers.join(", ")}"
  when 5
    sorted_numbers = bubble_sort_desc(numbers.dup)
    puts "Відсортований список за методом 'бульбашки': #{sorted_numbers.join(", ")}"
  when 0
    puts "До побачення!"
    break
  else
    puts "Невірний вибір. Виберіть 1, 2, 3, 4, 5 чи 0"
  end
end
