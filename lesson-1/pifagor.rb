puts "Введите первую сторону треугольника:"
a = gets.to_f

puts "Введите вторую сторону треугольника:"
b = gets.to_f

puts "Введите третью сторону треугольника:"
c = gets.to_f

cathetus_a, cathetus_b, hypotenuse = [a, b, c].sort!

if cathetus_a + cathetus_b <= hypotenuse
  abort("Такого треугольника не существует!")
end

right_triangle = cathetus_a**2 + cathetus_b**2 == hypotenuse**2
right_isosceles_triangle = right_triangle && cathetus_a == cathetus_b
equilateral_triangle = cathetus_a == hypotenuse

if right_isosceles_triangle
  puts "Треугольник прямоугольный и равнобедренный"
elsif right_triangle
  puts "Треугольник прямоугольный"
elsif equilateral_triangle
  puts "Треугольник равносторонний"
else
  puts "Треугольник никакой"
end
