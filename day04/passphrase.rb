
def valid? input
  words = input.split(" ")
  words.size == words.uniq.size
end

def anagram_valid? input
  words = input.split(" ").map { |s| s.chars.sort.join }
  words.size == words.uniq.size
end
