class Inst
  attr_reader :opcode, :reg, :offset

  def initialize(opcode, reg, offset)
    @opcode = opcode
    @reg = reg
    @offset = offset
  end

  def to_s
    tertiary = offset.nil? ? "" : ", #{@offset}"
    return "#{@opcode} #{@reg}" << tertiary
  end

end

class Comp

  DEF_REGS = {"a" => 0, "b" => 0}

  attr_reader :registers

  def initialize(insts, regs = DEF_REGS)
    @registers = regs
    @insts = insts
    @pc = 0
  end

  def exec_inst()
    if @pc >= @insts.size 
      return @registers["b"]
    end

    curr_inst = @insts[@pc]
    case curr_inst.opcode
    when "hlf"
      @registers[curr_inst.reg] /= 2
      @pc += 1
    when "tpl"
      @registers[curr_inst.reg] *= 3
      @pc += 1
    when "inc"
      @registers[curr_inst.reg] += 1
      @pc += 1
    when "jmp"
      jump_handler(curr_inst.reg, curr_inst.offset) { |reg| reg.nil? } 
    when "jie"
      jump_handler(curr_inst.reg, curr_inst.offset) { |reg| @registers[reg] % 2 == 0 }
    when "jio"
      jump_handler(curr_inst.reg, curr_inst.offset) { |reg| @registers[reg] == 1 } 
    end
    return nil # ruby implicit return
  end

  private

  def inf_loop_handler()
    puts "inf loop detected, ignore curr inst"
    @pc += 1
  end

  def jump_handler(register, offset)
    if offset == 0
      inf_loop_handler()
    elsif yield register
      @pc += offset
    else
      @pc += 1
    end
  end

end

def process_input(filename)
  lines = File.readlines(filename, chomp:true)
  insts = []

  for line in lines
    first_split = line.split(", ")
    second_split = first_split[0].split(" ")
    opcode = second_split[0]

    case opcode
    when "jmp"
      reg = nil
      offset = second_split[1].to_i
    when "jio", "jie"
      offset = first_split[1].to_i
      reg = second_split[1]
    else
      reg = second_split[1]
      offset = nil
    end

    inst = Inst.new(opcode, reg, offset)
    insts.push(inst)
  end
  return insts
end

def exec_insts(insts, regs=nil)
  comp = regs.nil? ? Comp.new(insts) : Comp.new(insts, regs)
  res = nil
  while res.nil?
    res = comp.exec_inst()
  end
  return res
end

insts = process_input(ARGV[0])
puts "Part One"
puts exec_insts(insts)
puts "Part Two"
regs = { "a" => 1, "b" => 0 }
puts exec_insts(insts, regs)
