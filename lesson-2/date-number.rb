puts "Введите день"
day = gets.to_i

puts "Введите месяц"
month = gets.to_i

puts "Введите год"
year = gets.to_i

months_day_count = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

is_leap = year % 4 == 0 && year % 100 != 0 || year % 400 == 0
months_day_count[1] += 1 if is_leap

puts "Порядковый номер даты #{day}.#{month}.#{year}: #{months_day_count.take(month -1).sum + day}"
