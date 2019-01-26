vowels = %w(а е ё и о у э ю я)
vowels_hash = Hash.new
('а'..'я').each_with_index do |letter, index|
  vowels_hash[letter] = index + 1 if vowels.include?(letter)
end
puts vowels_hash
