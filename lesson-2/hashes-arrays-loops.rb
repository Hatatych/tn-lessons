# Выводит месяцы, в которых кол-во дней = 30
months_day_count = {jan: 31, feb: 28, mar: 31, apr: 30, may: 31, jun: 30, jul: 31, aug: 31, sep: 30, oct: 31, nov: 30, dec: 31}
months_day_count.each do |month, daycount|
  if daycount == 30
    puts month
  end
end

# Заполняет массив от 10 до 100 с интервалом в 5
array = []
(10..100).step(5) { |i| array << i }

# Фибоначчи до 100
fibonacci_elements = [0, 1]
loop do
  new_element = fibonacci_elements[-2] + fibonacci_elements[-1]
  if new_element > 100
    break
  end
  fibonacci_elements << new_element
end

# Гласные
letter_position = 1
vowels = {}
('а'..'я').each do |letter|
  if "аеёиоуэюя".split("").include?(letter)
    vowels[letter] = letter_position
  end
  letter_position += 1
end
