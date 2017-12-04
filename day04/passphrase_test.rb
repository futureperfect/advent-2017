require "minitest/autorun"
require "./passphrase.rb"

class PassphraseTest < Minitest::Test

  def test_ex1
    input = "aa bb cc dd ee"
    assert valid?(input)
  end

  def test_ex2
    input = "aa bb cc dd aa"
    refute valid?(input)
  end

  def test_ex3
    input = "aa bb cc dd aaa"
    assert valid?(input)
  end

  def test_input
    f = File.new("input.txt")
    input = f.readlines
    valid_phrase_count = input.select {|line| valid? line.chomp }.count
    assert_equal 383, valid_phrase_count
  end
end

class AnagramTest < Minitest::Test
  def test_ex1
    input = "abcde fghij"
    assert anagram_valid?(input)
  end

  def test_ex2
    input = "abcde xyz ecdab"
    refute anagram_valid?(input)
  end

  def test_ex3
    input = "a ab abc abd abf abj"
    assert anagram_valid?(input)
  end

  def test_ex4
    input = "iiii oiii ooii oooi oooo"
    assert anagram_valid?(input)
  end

  def test_ex5
    input = "oiii ioii iioi iiio"
    refute anagram_valid?(input)
  end

  def test_input
    f = File.new("input.txt")
    input = f.readlines
    valid_phrase_count = input.select {|line| anagram_valid? line.chomp }.count
    assert_equal 265, valid_phrase_count
  end
end
