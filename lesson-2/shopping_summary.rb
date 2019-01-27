shopping_cart = {}

loop do
  puts "Введите название товара:"
  name = gets.chomp

  break if name == "stop"

  puts "Введите цену за единицу:"
  price_input = gets.to_i

  puts "Введите количество купленного товара:"
  qty_input = gets.to_f

  shopping_cart[name] = {price: price_input, qty: qty_input}
end

total = 0.0
puts shopping_cart
shopping_cart.each do |name, prices|
  product_total = prices[:price] * prices[:qty]
  total += product_total
  puts "Итого за #{name}: #{product_total}"
end

puts "Всего за покупки: #{total}"
