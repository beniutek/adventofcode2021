module Day01
  class << self
    def load_input
      IO.readlines('day01input.txt').map { |line| line.chomp.to_i }
    end

    def part1
      measurements = load_input
      count = 0
      prev = measurements.first

      measurements.each do |measurement|
        count += 1 if prev < measurement
          
        prev = measurement
      end

      { count: count }
    end

    def part2
      measurements = load_input
      prev_sum = measurements.first(3).sum
      count = 0

      measurements.each_cons(3) do |arr|
        current_sum = arr.sum
        count += 1 if prev_sum < current_sum 

        prev_sum = current_sum
      end

      { count: count }
    end
  end
end
