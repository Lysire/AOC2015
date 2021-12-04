def process_input(filename)
 lines = File.readlines(filename)
 values = []
 lines.each { |str|
   tmp = str.split("x")
   values.push(tmp.map { |str| str.to_i })
 }
return values
end

def get_wrap_area(present_dim)
  l, w, h = present_dim
  areas = [l * w, w * h, h * l]
  res = 2 * areas.sum + areas.min
return res
end

def get_ribbon_length(present_dim)
  l, w, h = present_dim
  present_dim.sort!
  min_1, min_2 = present_dim[0], present_dim[1]
return l*w*h + 2 * (min_1 + min_2)
end

total_area = 0
total_length = 0
values = process_input(ARGV[0])
values.each { |dim|
  total_area += get_wrap_area(dim)
  total_length += get_ribbon_length(dim)
}
puts total_area
puts total_length
