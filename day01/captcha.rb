
def captcha_v2(input)
  sum = 0
  rle = input.chomp.chars.chunk {|c| c}.to_a
  if rle.first[0] == rle.last[0]
    first = rle.shift
    last = rle.pop
    sum += first[0].to_i * ((first[1].length + last[1].length) - 1)
  end
  rle.each do |c, seq|
    if seq.length > 1
      sum += c.to_i * (seq.length - 1)
    end
  end
  sum
end

def captcha(input)
  sum = 0
  a = input.chomp.chars.to_a
  a << a.first.dup
  a.each_with_index do |e, i|
    sum += e.to_i if a[i] == a[i+1]
  end
  sum
end

def complement_captcha(input)
  sum = 0
  a = input.chomp.chars.to_a
  a.each_with_index do |e, i|
    root = a[i]
    complement_index = (i + (a.size / 2)) % a.size
    complement = a[complement_index]
    sum += e.to_i if root == complement
  end
  sum
end


