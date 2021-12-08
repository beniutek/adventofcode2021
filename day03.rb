module Day03
  class << self
    def load_input
      IO.readlines('day03input.txt').map { |line| line.chomp.split('').map { |x| x.to_i } }
    end

    def part1
      report = load_input
      byte_size = report.first.size
      zero_bit_counts = []
      gamma_byte = []
      epsilon_byte = []
      size = report.size

      report.transpose.each do |column|
        zeros = column.count(0) > size/2
        gamma_bit = zeros ? 0 : 1
        epsilon_bit = zeros ? 1 : 0

        gamma_byte << gamma_bit
        epsilon_byte << epsilon_bit
      end

      gamma_val = gamma_byte.join.to_i(2)
      epsilon_val = epsilon_byte.join.to_i(2)

      return { 
        gamma_byte: gamma_byte,
        gamma_val: gamma_val,
        epsilon_byt: epsilon_byte,
        epsilon_val: epsilon_val,
        result:  gamma_val * epsilon_val
      }
    end

    def part2
      report = load_input
      oxygen_rating_bytes = find_rating(report, 0, :>)
      co2_rating_bytes = find_rating(report, 0, :<=)
      oxygen_val = oxygen_rating_bytes.join.to_i(2)
      co2_val = co2_rating_bytes.join.to_i(2)

      return { 
        oxygen_rating_bytes: oxygen_rating_bytes,
        oxygen_val: oxygen_val,
        co2_rating_bytes: co2_rating_bytes,
        co2_val: co2_val,
        result:  oxygen_val * co2_val
      }
    end

    def find_rating(arr, index, criteria)
      column = arr.transpose[index]
      bit = column.count(0).send(criteria, column.size/2) ? 0 : 1

      new_arr = arr.select { |row| row[index] == bit }

      return new_arr if new_arr.size == 1

      find_rating(new_arr, index + 1, criteria)
    end
  end
end