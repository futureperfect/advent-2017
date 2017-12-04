def checksum(input)
  sheet = build_matrix(input)

  sheet.collect do |row|
    mm = row.minmax
    mm[1] - mm[0]
  end.sum
end

def build_matrix(input)
  input.chomp.split("\n").collect do |row|
    row.split("\t").map(&:to_i)
  end
end

def even_checksum(input)
  sheet = build_matrix(input)
  row_pairs = sheet.collect do |row|
    p = row.combination(2).find do |pair|
      mm = pair.minmax
      mm[1] % mm[0] == 0
    end
    p.minmax

  end

  row_pairs.map {|p| p[1] / p[0] }.sum
end
