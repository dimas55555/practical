
# Початкові значення
rows = 4
columns = 8
pie = Array.new(rows) { Array.new(columns, "_") }
row_number = 1 - 1
column_number = 2 - 1
pie[row_number][column_number] = "*"
row_number = 2 - 1
column_number = 7 - 1
pie[row_number][column_number] = "*"
row_number = 3 - 1
column_number = 5 - 1
pie[row_number][column_number] = "*"
row_number = 4 - 1
column_number = 3 - 1
pie[row_number][column_number] = "*"

#Визначення кількосиі родзинок
def count_rasins(pie)
  count = 0
  pie.each do |row|
    row.each do |cell|
      count += 1 if cell == "*"
    end
  end
  count
end

# Метод для виведення пирога
def print_pie(pie)
  pie.each do |row|
    puts row.join(" ")
  end
end


# Не вийшло зробити
def find_cake_slices(pie)
  slices = []

  def explore(pie, row, col, current_slice, slices)
    return unless row >= 0 && row < pie.length && col >= 0 && col < pie[0].length

    if pie[row][col] == "*"
      current_slice[row][col] = "*"
      pie[row][col] = "_"

      # Змінено: Додаємо кусок пирога до списку slices
      slices << Marshal.load(Marshal.dump(current_slice))

      explore(pie, row - 1, col, current_slice, slices)
      explore(pie, row + 1, col, current_slice, slices)
      explore(pie, row, col - 1, current_slice, slices)
      explore(pie, row, col + 1, current_slice, slices)
    end
  end

  pie.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      if cell == "*"
        current_slice = Array.new(pie.length) { Array.new(pie[0].length, "_") }
        explore(pie, i, j, current_slice, slices)
      end
    end
  end

  slices
end

def print_slice(slice)
  slice.each do |row|
    puts row.join(" ")
  end
end

# Головне меню програми
loop do
  puts "Меню:"
  puts "1. Запустити програму"
  puts "0. Вихід"

  print "Будь ласка, виберіть опцію: "
  main_choice = gets.chomp.to_i

  case main_choice
  when 1
    # Меню "Запустити програму"
    loop do
      puts "Меню 'Запустити програму':"
      puts "1. Задати базові нові значення"
      puts "2. Змінити базові"
      puts "3. Переглянути пиріг"
      puts "4. Розділити на рівні частини"# не вийшло зробити, працює не вірно
      puts "0. Повернутися назад"

      print "Будь ласка, виберіть опцію: "
      choice = gets.chomp.to_i

      case choice
      when 1
        # Задання базових нових значень
        print "Введіть кількість рядків: "
        rows = gets.chomp.to_i
        while rows <= 0 do
          print "Будь ласка, введіть додатне число для кількості рядків: "
          rows = gets.chomp.to_i
        end
        print "Введіть кількість стовпців: "
        columns = gets.chomp.to_i
        while columns <= 0 do
          print "Будь ласка, введіть додатне число для кількості стовпців: "
          columns = gets.chomp.to_i
        end
        pie = Array.new(rows) { Array.new(columns, "_") }
        # Додавання родзинки
        n_rasins = count_rasins(pie)
        if n_rasins < 10
          print "Введіть номер рядка: "
          row_number = gets.chomp.to_i - 1
          print "Введіть номер стовпця: "
          column_number = gets.chomp.to_i - 1
          if row_number >= 0 && row_number < rows && column_number >= 0 && column_number < columns
            if pie[row_number][column_number] == "_"
              pie[row_number][column_number] = "*"
            else
              puts "Ця клітина вже містить родзинку."
            end
          else
            puts "Неправильний номер рядка або стовпця. Будь ласка, виберіть існуючі номери."
          end
        else
          puts "Ви вже додали максимальну кількість родзинок (10)."
        end
      when 2
        # Меню "Змінити базові"
        loop do
          puts "Меню 'Змінити базові':"
          puts "1. Змінити кількість рядків"
          puts "2. Змінити кількість стовпців"
          puts "3. Додати родзинку"
          puts "4. Видалити родзинку"
          puts "0. Повернутися назад"

          print "Будь ласка, виберіть опцію: "
          sub_choice = gets.chomp.to_i

          case sub_choice
          when 1
            # Зміна кількості рядків
            print "Введіть нову кількість рядків: "
            begin
              new_rows = Integer(gets.chomp)
              if new_rows > 0
                rows = new_rows
                pie = Array.new(rows) { Array.new(columns, "_") }
              else
                puts "Кількість рядків повинна бути більше за 0."
              end
            rescue ArgumentError
              puts "Неправильний ввід. Будь ласка, введіть ціле число."
            end
          when 2
            # Зміна кількості стовпців
            print "Введіть нову кількість стовпців: "
            begin
              new_columns = Integer(gets.chomp)
              if new_columns > 0
                columns = new_columns
                pie = Array.new(rows) { Array.new(columns, "_") }
              else
                puts "Кількість стовпців повинна бути більше за 0."
              end
            rescue ArgumentError
              puts "Неправильний ввід. Будь ласка, введіть ціле число."
            end
          when 3
            # Додавання родзинки
            n_rasins = count_rasins(pie)
            if n_rasins < 10
              print "Введіть номер рядка: "
              row_number = gets.chomp.to_i - 1
              print "Введіть номер стовпця: "
              column_number = gets.chomp.to_i - 1

              if row_number >= 0 && row_number < rows && column_number >= 0 && column_number < columns
                if pie[row_number][column_number] == "_"
                  pie[row_number][column_number] = "*"
                else
                  puts "Ця клітина вже містить родзинку."
                end
              else
                puts "Неправильний номер рядка або стовпця. Будь ласка, виберіть існуючі номери."
              end
            else
              puts "Ви вже додали максимальну кількість родзинок (10)."
            end
          when 4
            # Видалення родзинки
            n_rasins = count_rasins(pie)
            if n_rasins-1 > 0
              print "Введіть номер рядка: "
              row_number = gets.chomp.to_i - 1
              print "Введіть номер стовпця: "
              column_number = gets.chomp.to_i - 1

              if row_number >= 0 && row_number < rows && column_number >= 0 && column_number < columns
                if pie[row_number][column_number] == "*"
                  pie[row_number][column_number] = "_"
                else
                  puts "Ця клітина не містить родзинку."
                end
              else
                puts "Неправильний номер рядка або стовпця. Будь ласка, виберіть існуючі номери."
              end
            else
              puts "Немає родзинок для видалення."
            end
          when 0
            # Повернення назад
            break
          else
            puts "Неправильний вибір опції. Будь ласка, виберіть вірний номер опції."
          end
        end
      when 3
        # Перегляд масиву
        print_pie(pie)
      when 4
        # Знаходження всіх варіантів розрізу пирога
        cake_slices = find_cake_slices(pie)

        # Вивід шматків пирога з родзинкою окремо
        puts "Знайдено шматків пирога з однією родзинкою: #{cake_slices.length}"
        cake_slices.each_with_index do |slice, index|
          puts "Шматок #{index + 1}:"
          print_slice(slice)
        end
      when 0
        # Повернення назад
        break
      else
        puts "Неправильний вибір опції. Будь ласка, виберіть вірний номер опції."
      end
    end
  when 0
    # Вихід з програми
    puts "Дякую за використання програми. До побачення!"
    break
  else
    puts "Неправильний вибір опції. Будь ласка, виберіть вірний номер опції."
  end
end
