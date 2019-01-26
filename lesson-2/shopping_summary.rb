shopping_cart = Hash.new

loop do
  puts "Введите название товара:"
  name = gets.chomp

  if name == "stop"
    break
  end

  puts "Введите цену за единицу:"
  price_input = gets.to_i

  puts "Введите количество купленного товара:"
  qty_input = gets.to_f

  shopping_cart[name] = {price: price_input, qty: qty_input}
end

summary = 0.0
puts shopping_cart
shopping_cart.each do |name, prices|
  summary += prices[:price] * prices[:qty]
  puts "Итого за #{name}: #{prices[:price] * prices[:qty]}"
end

puts "Всего за покупки: #{summary}"
