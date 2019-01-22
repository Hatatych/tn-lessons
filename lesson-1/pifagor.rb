puts "Введите первую сторону треугольника:"
a = gets.to_f

puts "Введите вторую сторону треугольника:"
b = gets.to_f

puts "Введите третью сторону треугольника:"
c = gets.to_f

if a + b <= c || a + c <= b || b + c <= a
  abort("Такого треугольника не существует!")
end

cat_a, cat_b, hyp = [a, b, c].sort!
flags = { "90deg" => false, "twosides" => false, "allsides" => false }

if cat_a ** 2 + cat_b ** 2 == hyp ** 2
  flags["90deg"] = true
end

if cat_a == cat_b && cat_a != hyp || cat_a == hyp && cat_a != cat_b || cat_b == hyp && cat_b != cat_a
  flags["twosides"] = true
end

if cat_a == cat_b && cat_a == hyp
  flags["allsides"] = true
end

if flags["90deg"] && flags["twosides"]
  puts "Треугольник прямоугольный и равнобедренный"
elsif flags["90deg"]
  puts "Треугольник прямоугольный"
elsif flags["twosides"]
  puts "Треугольник равнобедренный"
elsif flags["allsides"]
  puts "Треугольник равносторонний"
else
  puts "Треугольник никакой"
end
    