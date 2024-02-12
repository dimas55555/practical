def valid_ipv4?(ip)
  parts = ip.split(".")
  return false unless parts.length == 4
  # Перевірка кожної ділянки на відповідність умовам IPv4-адреси
  parts.all? do |part|
    # Перевірка, чи є частина числом і чи знаходиться в межах від 0 до 255
    part.match?(/^\d+$/) && (0..255).cover?(part.to_i) &&
      # Перевірка, чи немає ведучих нулів (крім випадку, коли частина дорівнює 0)
      (part.to_i.to_s == part)
  end
end

loop do
  # Вивести меню
  puts "Меню:"
  puts "1. Перевірити IPv4-адресу"
  puts "0. Вихід"
  print "Виберіть опцію: "
  choice = gets.chomp.to_i

  case choice
  when 1
    # Запитати користувача ввести IP-адресу
    print "Введіть IPv4-адресу: "
    ip_address = gets.chomp

    # Перевірити чи введена IP-адреса є коректною IPv4-адресою
    if valid_ipv4?(ip_address)
      puts "Це коректна IPv4-адреса."
    else
      puts "Це не коректна IPv4-адреса."
    end
  when 0
    # Вийти з програми
    puts "Дякую за використання програми. До побачення!"
    break
  else
    puts "Невірна опція. Будь ласка, спробуйте знову."
  end
end
