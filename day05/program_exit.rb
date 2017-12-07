class Computer
  attr_reader :pc, :ticks, :program

  def initialize program
    @pc = 0
    @ticks = 0
    @program = program
  end

  def run!
    while runnable?
      tick!
    end
  end

  def runnable?
    (0..(program.size-1)).cover? pc
  end

  def tick!
    instruction = program[pc]
    @program[pc] = update_instruction(instruction)
    @pc += instruction
    @ticks += 1
  end

  def update_instruction(instruction)
    instruction + 1
  end
end

def read_program
  f = File.new("input.txt")
  f.readlines.collect {|l| l.chomp.to_i }
end
