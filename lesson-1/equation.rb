puts "Введите первый коэффициент:"
a = gets.to_f

puts "Введите второй коэффициент:"
b = gets.to_f

puts "Введите третий коэффициент:"
c = gets.to_f

d = b ** 2 - 4 * a * c
rootd = Math.sqrt(d)

if d > 0
  x1 = (-b + rootd) / (2. * a)
  x2 = (-b - rootd) / (2. * a)
  puts "Дискриминант: #{d}. Корни: #{x1} и #{x2}"
elsif d == 0 
  x1 = (-b + rootd) / (2. * a)
  puts "Дискриминант: #{d}. Корень: #{x1}"
else
  puts "Дискриминант: #{d}. Корней нет."
end
