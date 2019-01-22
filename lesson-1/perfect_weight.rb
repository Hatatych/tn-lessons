puts "Как зовут?"
name = gets.chomp.capitalize

puts "Рост?"
height = gets.to_i

weight = height - 110
if weight >= 0
  puts "#{name}, твой идеальный вес: #{weight}"
else
  puts "Ваш вес уже оптимальный"
end
