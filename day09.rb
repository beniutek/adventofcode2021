module Day09
  class << self
    def load_input
      IO.readlines('day09input.txt', chomp: true).map { |line| line.chars.map(&:to_i) }
    end

    def part1
      map = load_input
      smol = []

      map.each_with_index do |row, i|
        row.each_with_index do |element, j|
          if generic_smallest(i, j, map)
            smol << element 
          end
        end
      end

      sum = 0
      smol.each do |x| sum = sum + x + 1 end
      {
        smol: sum,
        sum: smol.sum,
        size: smol.size,
        risk: smol.sum + smol.size
      }
    end
    
    def generic_smallest(i, j, map)
      map[i][j] < right(i, j, map) &&
      map[i][j] < left(i, j, map) &&
      map[i][j] < top(i, j, map) &&
      map[i][j] < bottom(i, j, map)
    end

    def left(i,j, map)
      return 9 if j-1 < 0
      map.at(i)&.at(j-1) || 9
    end

    def right(i, j, map)
      map.at(i)&.at(j+1) || 9
    end

    def top(i, j, map)
      return 9 if i-1 < 0
      map.at(i-1)&.at(j) || 9
    end
    
    def bottom(i, j, map)
      map.at(i+1)&.at(j) || 9
    end

    def part2
      map = load_input
      basin_sizes = []

      columns_size = map.first.size
      rows_size = map.size

      memo = Array.new(rows_size) { Array.new(columns_size) }

      map.each_with_index do |row, i|
        row.each_with_index do |element, j|
          if generic_smallest(i, j, map)
            basin_sizes << basin_size(i, j, map, memo, rows_size, columns_size)
          end
        end
      end

      {
        result: basin_sizes.max(3),
        multiplication: basin_sizes.max(3).reduce(1) { |acc,x| acc*x }
      }
    end
    
    def basin_size(i, j, map, memo, rows_size, columns_size)
      center = map[i][j]

      size = memo[i][j] ? 0 : 1
      memo[i][j] = true

      left_val = left(i,j,map)
      right_val = right(i,j,map)
      up_val = top(i,j,map)
      down_val = bottom(i,j,map)

      go_left = center < left_val && left_val < 9 && j > 0
      go_right = center < right_val && right_val < 9 && j < columns_size
      go_up = center < up_val && up_val < 9 && i > 0
      go_down = center < down_val && down_val < 9 && i < rows_size

      if go_right
        size += basin_size(i, j + 1, map, memo, rows_size, columns_size)
      end

      if go_left
        size += basin_size(i, j - 1, map, memo, rows_size, columns_size)
      end
      
      if go_up
        size += basin_size(i - 1, j, map, memo, rows_size, columns_size)
      end

      if go_down
        size += basin_size(i + 1, j, map, memo, rows_size, columns_size)
      end

      return size
    end
  end
end
