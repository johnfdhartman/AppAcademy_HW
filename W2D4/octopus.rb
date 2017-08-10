def sluggish_octopus(fishes)
  #oh my god this algorithm is bad
  fish_index_ranking = []
  largest_found = [0,0]
  fishes.each.with_index do |fish1, idx1|
    value = 0
    fishes.each_with_index do |fish2, idx2|
      if fish1.length > fish2.length
        value +=1
      end
    end
    if value > largest_found[1]
      largest_found = [idx1, value]
    end
  end
  fishes[largest_found[0]]
end

def dominant_octopus(fishes)
  sorted_fish = fishes.sort {|fish| fish.length}
  sorted_fish.first
end

def clever_octopus(fishes)
  best_value, best_index = 0,0
  fishes.each.with_index do |fish, idx|
    if fish.length > best_value
      best_value = fish.length
      best_index = idx
    end
  end
  fishes[best_index]
end

def slow_dance(direction, tiles_array)
  tiles_array.length.times do |i|
    if tiles_array[i] == direction
      return i
    end
  end
end


def fast_dance(direction)
  move_hash = {"up" => 0, "right-up" => 1, "right" => 2,
    "right-down" => 3, "down" => 4, "left-down" => 5,
    "left" => 6,  "left-up" => 7}
  move_hash[direction]
end
