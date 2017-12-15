require "minitest/autorun"
require "./process_connectivity.rb"

class ProcessConnectivityTest < Minitest::Test
  def test_parse_line
    input = "8 <-> 704"
    result = parse(input)
    assert_equal [8, 704], result
  end

  def test_identity
    input = "1 <-> 1"
    result = parse(input)
    assert_equal [1], result
  end

  def test_multiple_connection
    input = "2 <-> 0, 3, 4"
    result = parse(input)
    assert_equal [0, 2, 3, 4], result
  end

  def test_find_absent
    uf = UF.new
    assert_nil uf.find_root(7)
  end

  def test_find_present
    uf = UF.new
    uf.add(1)
    assert_equal 1, uf.find_root(1)
  end

  def test_disconnected
    uf = UF.new
    uf.add(1)
    uf.add(3)
    refute uf.connected?(1, 3) 
  end

  def test_simple_union
    uf = UF.new
    uf.add(1)
    uf.add(3)
    uf.union(1, 3)
    assert uf.connected?(1, 3)
  end

  def test_complex_union
    uf = UF.new
    [1, 3, 7, 13, 23].each do |e|
      uf.add(e)
    end
    uf.union 1, 3
    uf.union 7, 13
    uf.union 23, 23
    refute uf.connected?(3, 13)
    assert uf.connected?(7, 13)
  end

  def test_provided
    input = read_input
    assert_equal 2000, input.size
  end

  def test_size_of_root_cluster
    uf = build_process_disjoint_set
    root = uf.find_root(0)
    assert_equal 380, uf.cluster_size(root) 
  end

  def test_number_of_components
    uf = build_process_disjoint_set
    assert_equal 181, uf.connected_component_count
  end

  def parse input
    input.gsub(/<->/, ",").gsub(/ /, "").split(",").map(&:to_i).uniq.sort
  end

  def read_input
    f = File.new("input.txt")
    f.readlines.collect do |l|
      parse(l.chomp)
    end
  end

  def build_process_disjoint_set
    uf = UF.new
    input = read_input
    input.each do |l|
      l.each { |i| uf.add(i) }
      f = l.shift
      l.each { |i| uf.union(f, i) }
    end
    uf
  end
end
