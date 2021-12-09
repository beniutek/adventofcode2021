# 2199943210
# 3987894921
# 9856789892
# 8767896789
# 9899965678

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
    end
  end
end
