def process_input(filename)
  lines = File.readlines(filename)
  return lines
end

def get_house_present_info(dir_string)
  pres_dist = {}
  prev_coord = [0, 0]
  pres_dist[prev_coord] = 1 # present to origin
  dir_string.each_char { |dir|
    curr_coord = prev_coord.clone
    case dir

      when "<"
        curr_coord[0] -= 1
      when ">"
        curr_coord[0] += 1
      when "^"
        curr_coord[1] += 1
      when "v"
        curr_coord[1] -= 1
      else

    end

    pres_dist.has_key?(curr_coord) ? pres_dist[curr_coord] += 1 : pres_dist[curr_coord] = 1

    prev_coord = curr_coord

  }
  return pres_dist
end

def get_num_houses_one_pres(pres_dist)
  return (pres_dist.filter { |k,v| v >= 1 }).size
end

def get_sep_dir_strings(dir_string)
  norm_dirs = ""
  robo_dirs = ""

  dir_string.length.times { |i| 
    i % 2 == 0 ? norm_dirs << dir_string[i] : robo_dirs << dir_string[i]
  }

  return norm_dirs, robo_dirs
end

def get_num_houses_one_pres_robo(pres_dist, robo_pres_dist)
  updated = pres_dist.clone
  robo_pres_dist.each { |k,v| 
    updated[k] ||= 0
    updated[k] += v
  }
  return (updated.filter{ |k,v| v >= 1 }).size
end

puts "First Part"

dir_strings = process_input(ARGV[0])
dir_strings.each { |dir_string|
  pres_dist = get_house_present_info(dir_string)
  puts get_num_houses_one_pres(pres_dist)
}

puts "Second Part"

dir_strings.each { |dir_string|
  norm_dirs, robo_dirs = get_sep_dir_strings(dir_string)
  pres_dist = get_house_present_info(norm_dirs)
  robo_pres_dist = get_house_present_info(robo_dirs)
  puts get_num_houses_one_pres_robo(pres_dist, robo_pres_dist)
}
