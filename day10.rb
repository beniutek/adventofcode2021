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
    end
  end
end
