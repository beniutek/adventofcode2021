module Day07
  class << self
    def load_input
      IO.readlines('day07input.txt').map { |line| line.split(',').map(&:to_i) }.first
    end

    def part1
      input = load_input

      min, max = input.min, input.max
      fuel_costs = {}
      (min..max).each do |i|
        fuel_costs[i] = compute_fuel_cost(input, i)
      end

      min = 9999999999999999
      min_key = 0

      fuel_costs.each do |key, val|
        if val < min
          min_key = key
          min = val
        end
      end

      {
        fuel_costs: fuel_costs.min,
        min: min,
        key: min_key
      }
    end

    def compute_fuel_cost(arr, desired_position)
      arr.reduce(0) do |cost, current_position|
        cost += (current_position - desired_position).abs
      end
    end

    def part2
      input = load_input
      min, max = input.min, input.max
      fuel_costs = {}
      pp input
      
      (min..max).each do |i|
        fuel_costs[i] = compute_fuel_cost2(input, i)
      end

      min = 9999999999999999
      min_key = 0

      fuel_costs.each do |key, val|
        if val < min
          min_key = key
          min = val
        end
      end
      
      {
        fuel_costs: fuel_costs,
        min: min,
        key: min_key
      }
    end

    def compute_fuel_cost2(arr, desired_position)
      total_cost = arr.reduce(0) do |total_cost, current_position|
        min = 1
        max = (current_position - desired_position).abs
        #size = (min..max).size
        current_cost = (min + max)*max/2
        total_cost += current_cost
      end

      total_cost
    end
  end
end
