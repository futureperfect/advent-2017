require "minitest/autorun"
require "./program_exit.rb"

class ProgramExitTest < Minitest::Test
  def test_ingest_program
    program = read_program
    assert program.instance_of?(Array)
    assert_equal 1033, program.size
  end

  def test_provided_escape_count
    program = read_program
    c = Computer.new(program)

    c.run!

    assert_equal 351282, c.ticks
  end

  def test_basic_execution
    c = Computer.new [0]

    c.tick!

    assert_equal [1], c.program
    assert_equal 0, c.pc
  end

  def test_simple_escape
    c = Computer.new [1]

    c.run!

    assert_equal 1, c.ticks
  end

  def test_example
    c = Computer.new [0, 3, 0, 1, -3]

    c.tick!

    assert_equal [1, 3, 0, 1, -3], c.program
    assert_equal 0, c.pc
  end
end
