vowels = "аеёиоуэюя"
vowels_hash = {}
('а'..'я').each_with_index do |letter, index|
  vowels_hash[letter] = index + 1 if vowels[letter]
end
puts vowels_hash
