def compute_prefix_function(pattern)
  m = pattern.length
  pi = [0] * m
  k = 0

  (1...m).each do |q|
    while k > 0 && pattern[k] != pattern[q]
      k = pi[k - 1]
    end

    if pattern[k] == pattern[q]
      k += 1
    end

    pi[q] = k
  end

  pi
end

def kmp_search(text, pattern)
  n = text.length
  m = pattern.length
  pi = compute_prefix_function(pattern)
  q = 0
  indices = []

  (0...n).each do |i|
    while q > 0 && pattern[q] != text[i]
      q = pi[q - 1]
    end

    if pattern[q] == text[i]
      q += 1
    end

    if q == m
      indices << i - m + 1
      q = pi[q - 1]
    end
  end

  indices
end

# Приклад використання
text = "ABABDABACDABABCABAB"
pattern = "ABABCABAB"
puts "text: #{text}"
puts "pattern: #{pattern}"
result = kmp_search(text, pattern)
puts "Знайдені входження: #{result}"
