puts "Как зовут?"
name = gets.chomp

puts "Рост?"
height = gets.chomp

weight = height.to_i - 110
puts "#{name}, твой идеальный вес: #{weight}"
if weight < 0
    puts "Ваш вес уже оптимальный"
end