vowels = "аеёиоуэюя"
vowels_hash = Hash.new
('а'..'я').each_with_index { |letter, index| vowels_hash[letter] = index + 1 if vowels[letter] }
puts vowels_hash
