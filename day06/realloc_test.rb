require "minitest/autorun"
require "./realloc.rb"

class ReallocTest < Minitest::Test
  def test_cycles_until_repeat
    input = [0, 5, 10, 0, 11, 14, 13, 4, 11, 8, 8, 7, 1, 4, 12, 11]
    m = Memory.new input
    cycle_size = find_repeats(m)
    assert_equal 7864, cycle_size[1]
  end

  def test_finding_loop_size
    input = [0, 5, 10, 0, 11, 14, 13, 4, 11, 8, 8, 7, 1, 4, 12, 11]
    m = Memory.new input
    cycle_size = find_repeats(m)
    assert_equal 1695, cycle_size[1] - 1 - cycle_size[0]
  end

  def test_unbalanced
    m = Memory.new [0, 2, 7, 0]
    refute m.balanced?
  end

  def test_balanced
    m = Memory.new [1, 1, 1, 1]
    assert m.balanced?
  end

  def test_heaviest
    m = Memory.new [0, 2, 7, 0]
    assert_equal 2, m.heaviest_bank
  end

  def test_redistribute_heaviest
    m = Memory.new [0, 2, 7, 0]

    m.redistribute_heaviest!
    assert_equal [2, 4, 1, 2], m.memory

    m.redistribute_heaviest!
    assert_equal [3, 1, 2, 3], m.memory

    m.redistribute_heaviest!
    assert_equal [0, 2, 3, 4], m.memory
  end

  def test_simple_cycles_until_repeat
    m = Memory.new [0, 2, 7, 0]
    cycle_size = find_repeats(m)
    assert_equal 5, cycle_size[1]
  end
end
