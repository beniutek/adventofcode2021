#   0:      1:      2:      3:      4:
#  aaaa    ....    aaaa    aaaa    ....
# b    c  .    c  .    c  .    c  b    c
# b    c  .    c  .    c  .    c  b    c
#  ....    ....    dddd    dddd    dddd
# e    f  .    f  e    .  .    f  .    f
# e    f  .    f  e    .  .    f  .    f
#  gggg    ....    gggg    gggg    ....

#   5:      6:      7:      8:      9:
#  aaaa    aaaa    aaaa    aaaa    aaaa
# b    .  b    .  .    c  b    c  b    c
# b    .  b    .  .    c  b    c  b    c
#  dddd    dddd    ....    dddd    dddd
# .    f  e    f  .    f  e    f  .    f
# .    f  e    f  .    f  e    f  .    f
#  gggg    gggg    ....    gggg    gggg

module Day08
  SEGMENT_MAP = {
    'abcefg'  => 0,
    'cf'      => 1, 
    'acdeg'   => 2,
    'acdfg'   => 3,
    'bcdf'    => 4,
    'abdfg'   => 5,
    'abdefg'  => 6,
    'acf'     => 7,
    'abcdefg' => 8,
    'abcdfg'  => 9
  }

  class << self
    def load_input
      IO.readlines('day08input.txt', chomp: true).map do |line|
        line.split('|').map do |x| 
          x.split(' ')
        end
      end
    end

    def part1
      outputs = []

      load_input.each do |signal, output|
        outputs << output
      end

      count = outputs.map do |output|
        output.count do |digit|
          [2,4,3,7].include? digit.size
        end
      end.sum

      {
        easy_digits: count
      }
    end

    def part2
      outputs = []
      signals = []

      load_input.each do |signal, output|
        signals << signal.map { |x| x.split('') }
        outputs << output.map { |x| x.split('') }
      end

      digits = []
      signals.size.times do |i|
        map = create_segment_map(signals[i], outputs[i])
        digits << get_digits(outputs[i], map).join('').to_i
      end

      {
        sum: digits.sum
      }
    end

    def get_digits(output, map)
      output.map do |segments|
        get_digit(segments, map)
      end
    end

    def get_digit(segments, map)
      tmp = []

      segments.each do |segment|
        tmp << map[segment]
      end

      SEGMENT_MAP[tmp.sort.join('')]
    end

    def create_segment_map(signal, output)
      map = { 0 => '', 1 => '', 2 => '', 3 => '', 4 => '', 5 => '', 6 => '', 7 => '', 8 => '', 9 => '' }
      common = { 'a' => 0, 'b' =>  0, 'c' =>  0, 'd' =>  0, 'e' =>  0, 'f' =>  0, 'g' => 0 }
      
      signal.each do |segments|
        map[1] = segments.join('') if segments.size == 2
        map[7] = segments.join('') if segments.size == 3
        map[4] = segments.join('') if segments.size == 4
        map[8] = segments.join('') if segments.size == 7

        segments.each do |line|
          common[line] += 1
        end
      end

      inverted = common.each_with_object({}) do |(key,value),out| 
        out[value] ||= []
        out[value] << key
      end

      segments = {}
      segments['f'] = inverted[9].first
      segments['e'] = inverted[4].first
      segments['b'] = inverted[6].first
      segments['c'] = map[1].delete(segments['f'])
      segments['a'] = map[7].gsub(/[#{segments['f']}#{segments['c']}]/, '')
      segments['d'] = map[4].gsub(/[#{segments['f']}#{segments['c']}#{segments['b']}]/, '')
      segments['g'] = map[8].gsub(/[#{segments['a']}#{segments['b']}#{segments['c']}#{segments['d']}#{segments['e']}#{segments['f']}#{segments['g']}]/, '')

      segments.each_with_object({}) do |(key,value),out| 
        out[value] = key
      end
    end
  end
end
