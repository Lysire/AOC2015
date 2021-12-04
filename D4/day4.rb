require 'digest'

def process_input(filename)
  lines = File.readlines(filename, chomp: true)
  return lines[0]
end

def get_smallest(string, num_zeros)
  res = 1
  digest = "#{string}#{res}"
  prefix = "0" * num_zeros
  
  while Digest::MD5.hexdigest(digest)[0..num_zeros - 1] != prefix
    res += 1
    digest = "#{string}#{res}"
  end

  return res
end

line = process_input(ARGV[0])
puts get_smallest(line, 5)
puts get_smallest(line, 6)
