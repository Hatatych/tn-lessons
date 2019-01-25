puts "Введите день"
day = gets.to_i

puts "Введите месяц"
month = gets.to_i

puts "Введите год"
year = gets.to_i

months_day_count = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

order = day
for i in 0..month-2
  order += months_day_count[i]
end

if month > 2
  if year % 4 == 0
    unless (year % 100 == 0) and (year % 100 != 0)
      order += 1
    end
  end
end

puts "Порядковый номер даты #{day}.#{month}.#{year}: #{order}"
