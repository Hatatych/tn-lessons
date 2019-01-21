puts "Введите первый коэффициент:"
a = gets.chomp.to_i

puts "Введите второй коэффициент:"
b = gets.chomp.to_i

puts "Введите третий коэффициент:"
c = gets.chomp.to_i

d = b ** 2 - 4 * a * c

if d > 0
    x1 = (-b + Math.sqrt(d)) / 2 * a
    x2 = (-b - Math.sqrt(d)) / 2 * a
    puts "Дискриминант: #{d}. Корни: #{x1} и #{x2}"
elsif d == 0 
    x1 = (-b + Math.sqrt(d)) / 2 * a
    puts "Дискриминант: #{d}. Корень: #{x1}"
else
    puts "Дискриминант: #{d}. Корней нет."
end