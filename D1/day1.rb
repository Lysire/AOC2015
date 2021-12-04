def process_input(filename)
  lines = File.readlines(filename)
return lines[0]
end

def determine_level(par_string)
  res = 0
  par_string.each_char { |c|
    res += 1 if c == "("
    res -= 1 if c == ")"
  }
return res
end

def determine_pos(par_string)
  res = 0
  pos = 0
  par_string.each_char { |c|
    pos += 1
    res += 1 if c == "("
    res -= 1 if c == ")"
    break if res < 0
  }
return pos
end

par_string = process_input(ARGV[0])
lvl = determine_level(par_string)
pos = determine_pos(par_string)
puts lvl
puts pos
