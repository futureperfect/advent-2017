class Memory
  attr_reader :memory
  def initialize banks
    @memory = banks
  end

  def balanced?
    @memory.uniq.size == 1
  end

  def heaviest_bank
    memory.index(memory.max)
  end


  def redistribute_heaviest!
   if !balanced?
     redistribute heaviest_bank
   end 
  end

  def redistribute index
    distributable_count = memory[index]
    memory[index] = 0

    current = (index + 1) % memory.size
    while distributable_count > 0
      memory[current] = memory[current] + 1
      distributable_count -= 1
      current = (current + 1) % memory.size
    end
  end
end

def find_repeats m
  state = []
  unique = true
  duplicate = nil

  while unique
    m.redistribute_heaviest!
    s = m.memory.dup
    if state.include?(s)
      duplicate = s
      unique = false
    end
    state << s 
  end
  [state.index(duplicate), state.size]
end
