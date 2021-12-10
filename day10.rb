module Day10
  class << self
    def load_input
      IO.readlines('day10input.txt').map { |line| line.chomp.split('') }
    end

    MAP = {
      '(' => ')',
      '[' => ']',
      '{' => '}',
      '<' => '>'
    }

    POINTS_MAP = {
      ')' => 3,
      ']' => 57,
      '}' => 1197,
      '>' => 25137
    }

    COMPLETION_POINTS_MAP = {
      ')' => 1,
      ']' => 2,
      '}' => 3,
      '>' => 4
    }

    CLOSING_CHARS = [']', ')', '}', '>']

    def part1
      input = load_input
      opening_chars = []
      offending_chars = []

      input.each do |line|
        line.each do |char|
          if CLOSING_CHARS.include? char
            opening_char = opening_chars.pop
            if MAP[opening_char] != char
              offending_chars << char
              break
            end
          else
            opening_chars << char
          end
        end

        opening_chars = []
      end

      {
        offending_chars: offending_chars.count,
        sum: offending_chars.map { |x| POINTS_MAP[x] }.sum
      }
    end

    def part2
      input = load_input
      opening_chars = []
      expected_closing_chars = []
      offending_chars = []
      broken_line = false
      points = []

      input.each_with_index do |line, i|
        line.each do |char|
          if CLOSING_CHARS.include? char
            opening_char = opening_chars.pop

            if MAP[opening_char] != char
              broken_line = true
              break
            end
          else
            opening_chars << char
            expected_closing_chars << MAP[char]
          end
        end

        if broken_line
          offending_chars = []
          expected_closing_chars = []
          opening_chars = []
          broken_line = false
        else
          closing_chars = []
          opening_chars.reverse_each do |char|
            closing_chars << MAP[char]
          end
          points << get_points(closing_chars)
          opening_chars = []
        end
      end

      {
        points: points.sort.at(points.size/2)
      }
    end

    def get_points(closing_chars)
      closing_chars.reduce(0) do |acc, val|
        acc * 5 + COMPLETION_POINTS_MAP[val]
      end
    end
  end
end
