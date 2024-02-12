
# Генерація початкової популяції
def generate_population(size, genes)
  population = []
  # Створюємо популяцію розміром 'size' з 'genes' генами для кожної особини
  size.times { population << Array.new(genes) { rand(2) } }
  population
end

# Обчислення придатності (фітнес-функції)
def fitness(individual)
  # Приклад функції для оптимізації: сума бітів у бінарному рядку
  individual.sum
end

# Вибір батьків за рулетковим вибором
def select_parents(population)
  # Обчислюємо суму придатності для всіх особин у популяції
  total_fitness = population.map { |individual| fitness(individual) }.sum
  # Обчислюємо ймовірності вибору кожної особини за рулетковим методом
  selection_probabilities = population.map { |individual| fitness(individual) / total_fitness.to_f }

  roulette_wheel = []
  # Заповнюємо "рулетку" з індексами особин залежно від їхньої ймовірності вибору
  selection_probabilities.each_with_index do |probability, index|
    (probability * 100).to_i.times { roulette_wheel << index }
  end

  parents = []
  # Вибираємо двох батьків випадковим чином за допомогою "рулетки"
  2.times { parents << population[roulette_wheel.sample] }
  parents
end

# Схрещення (однорівневий одноточковий кросовер)
def crossover(parents)
  # Випадково вибираємо точку схрещення між батьками
  crossover_point = rand(parents[0].size)
  # Схрещуємо батьківські гени, щоб отримати двох дітей
  child1 = parents[0][0...crossover_point] + parents[1][crossover_point..-1]
  child2 = parents[1][0...crossover_point] + parents[0][crossover_point..-1]
  [child1, child2]
  # після схрещення отримуємо двох нових особин, які мають частини генів від кожного з батьків.
  # Цей процес дозволяє поєднувати корисні частини генів різних батьків у сподіванні отримати більш адаптованих нащадків
  # у наступному поколінні популяції.
end

# Мутація (однобітова мутація)
def mutate(individual, mutation_rate)
  individual.map do |bit|
    # Мутація гена: з ймовірністю 'mutation_rate' змінити 1 на 0 або навпаки
    if rand < mutation_rate
      1 - bit
    else
      bit
    end
  end
end

# Генетичний алгоритм для оптимізації
def genetic_algorithm(population_size, num_generations, mutation_rate)
  # Генеруємо початкову популяцію
  population = generate_population(population_size, 10)

  # Проводимо 'num_generations' поколінь генетичного алгоритму
  num_generations.times do |generation|
    new_population = []

    # Формуємо нову популяцію
    until new_population.size == population_size
      # Вибираємо батьків для схрещення
      parents = select_parents(population)
      # Схрещуємо батьківські особини та мутуємо їх, отримуючи дітей
      children = crossover(parents)
      children.map! { |child| mutate(child, mutation_rate) }
      # Додаємо дітей до нової популяції
      new_population.concat(children)
    end

    # Оновлюємо популяцію новою популяцією
    population = new_population

    # Знаходимо та виводимо найкращу особину поточного покоління
    best_individual = population.max_by { |individual| fitness(individual) }
    puts "Покоління #{generation + 1}: Найкращий результат - #{fitness(best_individual)}"
  end
end

# Запуск генетичного алгоритму з параметрами: розмір популяції, кількість поколінь та шанс мутації
genetic_algorithm(100, 10, 0.5)

