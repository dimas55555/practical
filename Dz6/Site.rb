require 'nokogiri'
require 'open-uri'
require 'csv'
require 'mechanize'

# URL сайту, який буде парситися
url = 'https://www.hospitalsafetygrade.org/all-hospitals'

# Ініціалізація об'єкта Mechanize для взаємодії з веб-сторінкою
agent = Mechanize.new
page = agent.get(url)
doc = Nokogiri::HTML(page.body)

# Визначення назви та місця CSV-файлу для зберігання результатів
csv_filename = 'DZ6/results.csv'

# Відкриття CSV-файлу для запису результатів парсингу
CSV.open(csv_filename, 'w') do |csv|
  # Додавання заголовка CSV з іменами стовпців
  csv << %w[Name Link] # Заголовки

  # Парсинг даних і додавання їх у CSV-файл
  doc.css('.column1 #BlinkDBContent_849210 ul li a').each do |element|
    begin
      # Отримання тексту з тегу <a>
      data1 = element.text.strip

      # Формування посилання та збереження його значення
      data2 = URI.join(url, element['href']).to_s

      # Додавання даних у CSV-файл
      csv << [data1, data2]
    rescue StandardError => e
      # Обробка можливих помилок і виведення повідомлення
      puts "Помилка при обробці елемента: #{e.message}"
    end
  end
end

# Виведення повідомлення про успішне завершення роботи
puts "Дані були успішно збережені у файлі #{csv_filename}"
