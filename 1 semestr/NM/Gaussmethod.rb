# Метод Гауса для розв'язання системи лінійних рівнянь
def gaussian_elimination(matrix)
  n = matrix.size  # Отримуємо розмірність квадратної матриці

  # Прямий хід методу Гауса
  (0..n-1).each do |k|  # Проходимо по кожному стовпцю
    (k+1..n-1).each do |i|  # Проходимо по кожному рядку нижче поточного
      factor = matrix[i][k] / matrix[k][k]  # Обчислюємо множник для занулення елемента
      (k..n).each do |j|  # Проходимо по всім елементам у рядку
        # Зануляємо елементи у рядку
        matrix[i][j] -= factor * matrix[k][j]
      end
    end
  end

  # Обернений хід методу Гауса
  x = Array.new(n, 0)  # Масив для збереження розв'язків
  (n-1).downto(0).each do |i|  # Проходимо у зворотньому порядку по рядках
    x[i] = matrix[i][n]  # Ініціалізуємо змінну з правої частини системи рівнянь
    (i+1..n-1).each do |j|  # Проходимо по рядку після поточного
      # Відновлюємо розв'язок з використанням вже знайдених значень змінних
      x[i] -= matrix[i][j] * x[j]
    end
    # Нормалізуємо розв'язок
    x[i] /= matrix[i][i]
  end
  x   # Повертаємо масив розв'язків
end

# Введення коефіцієнтів рівняння з екранної форми
def input_coefficients(n)
  puts "Введіть коефіцієнти (#{n + 1} коефіцієнтів):"
  coefficients = gets.chomp.split.map(&:to_f)
  while coefficients.size != n + 1
    puts "Некоректна кількість коефіцієнтів. Будь ласка, введіть коефіцієнти ще раз."
    coefficients = gets.chomp.split.map(&:to_f)
  end
  coefficients
end

# Введення матриці з екранної форми
def input_matrix_from_screen
  puts "Введіть кількість рівнянь у системі:"
  n = gets.chomp.to_i
  matrix = []
  (1..n).each do |i|
    puts "Введіть коефіцієнти для рівняння #{i}:"
    matrix << input_coefficients(n)
  end
  matrix
end

# Виведення результату
def print_solution(x)
  puts "Розв'язок системи рівнянь:"
  x.each_with_index { |value, i| puts "x#{i+1} = #{value}" }
end

# Головна частина програми
if __FILE__ == $0
  loop do
    puts "Виберіть спосіб введення даних:"
    puts "1. Введення з екрану"
    puts "2. Завантаження з файлу"
    puts "0. Вихід"
    choice = gets.chomp.to_i

    case choice
    when 1
      matrix = input_matrix_from_screen
      solution = gaussian_elimination(matrix)
      print_solution(solution)
    when 2
      puts "Введіть назву файлу з матрицею:"
      filename = gets.chomp
      matrix = File.readlines(filename).map { |line| line.split.map(&:to_f) }
      solution = gaussian_elimination(matrix)
      print_solution(solution)
    when 0
      puts "Дякуємо за використання програми. До побачення!"
      break
    else
      puts "Некоректний вибір"
    end
  end
end
