def power_level_grid(serial_number)
  300.times.map do |y|
    300.times.map do |x|
      rack_id = x + 10
      power_level = (rack_id * y + serial_number) * rack_id
      power_level.to_s[-3].to_i - 5
    end
  end
end

def find_area(grid, size, current_max)
  area = { value: -5 * size * size + 1, x: 0, y: 0}
  return area if 5 * size * size < current_max
  (300 - size).times do |y|
    (300 - size).times do |x|
      area_power_level = grid.slice(y, size).map { |l| l.slice(x, size).sum }.sum
      area = { value: area_power_level, x: x, y: y } if area_power_level > area[:value]
    end
  end
  area
end

def find_best_area(grid)
  area = { value: -5, x: 0, y:0, size: 1}
  300.times do |size|
    found_area = find_area(grid, 300 - size, area[:value]) 
    area = { value: found_area[:value], x: found_area[:x], y: found_area[:y], size: 300- size } if found_area[:value] > area[:value]
  end
  area
end

input = 7139
grid = power_level_grid(input)
p find_best_area(grid)
