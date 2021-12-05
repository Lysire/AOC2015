def process_input(filename)
  lines = File.readlines(filename, chomp: true)
  return lines[0].to_i
end

def get_factors(number)
  limit = Math.sqrt(number).floor
  factors = {}

  for v in 1..limit do
    if number % v == 0
      factors[v] = nil
      factors[number / v] = nil
    end
  end
  
  return factors
end

# part two, filter factors
def filter_factors(factors, number, limit)
  return factors.filter { |k,v|
    limit * k >= number
  }
end

def get_score(number, multiplier, limit)
  factors = get_factors(number)
  
  if not limit.nil?
    factors = filter_factors(factors, number, limit)
  end

  res = 0

  factors.each_key { |k|
    res += k
  }

  return multiplier * res
end

def search(tgt_score, multiplier, limit)
  res = 1

  while get_score(res, multiplier, limit) < tgt_score
    res += 1
  end

  return res
end

number = process_input(ARGV[0])
factors = get_factors(number)

puts "First Part"
# puts search(number, 10, nil)
puts "Second Part"
puts search(number, 11, 50)
