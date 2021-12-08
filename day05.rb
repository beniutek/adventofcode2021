module Day05
  class << self
    def load_input
      IO.readlines('day05input.txt').map do |line|
        line.chomp.split(' -> ').map do |coords|
          coords.split(',').map(&:to_i)
        end
      end
    end

    def part1
      coords = load_input
      map = Array.new(1000) { Array.new(1000, 0) }
      coords.each do |start, finish|
        draw_line(map, start, finish)
      end
      
      sum = 0
      map.each do |row|
        row.each do |element|
          sum += 1 if element > 1
        end
      end

      {
        sum: sum
      }
    end

    def part2
      coords = load_input
      map = Array.new(1000) { Array.new(1000, 0) }
      
      coords.each do |start, finish|
        draw_line(map, start, finish, with_diagonal: true)
      end
      
      sum = 0

      map.each do |row|
        row.each do |element|
          sum += 1 if element > 1
        end
      end

      {
        sum: sum
      }
    end

    def draw_line(map, start, finish, with_diagonal: false)
      x1, y1 = start
      x2, y2 = finish

      return draw_horizontal_line(map, start, finish) if (y1 == y2)
      return draw_vertical_line(map, start, finish) if (x1 == x2)
      return draw_diagonal_line(map, start, finish) if with_diagonal
    end

    def draw_horizontal_line(map, start, finish)
      x1, y = start
      x2, _ = finish
 
      x1, x2 = x1 < x2 ? [x1, x2] : [x2, x1]

      (x1..x2).each do |x|
        map[y][x] += 1
      end
    end

    def draw_vertical_line(map, start, finish)
      x, y1 = start
      _, y2 = finish
      y1, y2 = y1 < y2 ? [y1, y2] : [y2, y1]

      (y1..y2).each do |y|
        map[y][x] += 1
      end
    end

    def draw_diagonal_line(map, start, finish)
      x1, y1 = start
      x2, y2 = finish

      x_sign = x1 < x2 ? :+ : :-
      y_sign = y1 < y2 ? :+ : :-
      x_steps = (x1 - x2).abs
      y_steps = (y1 - y2).abs

      xs1, xs2 = x1 < x2 ? [x1, x2] : [x2, x1]
      ys1, ys2 = y1 < y2 ? [y1, y2] : [y2, y1]

      (xs1..xs2).each_with_index do |x, i|
        (ys1..ys2).each_with_index do |y, j|
          if i == j       
            map[y1.send(y_sign, j)][x1.send(x_sign,i)] += 1 
          end
        end
      end
    end
  end
end
