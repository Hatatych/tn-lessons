# Фибоначчи до 100
fibonacci_elements = [0, 1]
loop do
  new_element = fibonacci_elements[-2] + fibonacci_elements[-1]
  break if new_element > 100
  fibonacci_elements << new_element
end
