module Day06
  class << self
    def load_input
      IO.readlines('day06input.txt').map { |line| line.split(',').map(&:to_i) }.flatten
    end

    def part1
      school = load_input

      80.times do |i|
        school, new_fishes = time_tick(school)
        school += new_fishes
      end

      dict_school = make_dict(school)

      {
        total:dict_school.values.sum,
        dict: dict_school
      }
    end

    def part2
      dict_school = make_dict(load_input)

      pp dict_school

      256.times do |i|
        one_day_moooooreee(dict_school)
      end

      {
        total:dict_school.values.sum,
        dict: dict_school
      }
    end

    def make_dict(arr)
      arr.reduce({}) do |acc, i|
        acc[i] ||= 0
        acc[i] += 1
        acc
      end
    end

    def one_day_moooooreee(school)
      fishes = []

      fishes[8] = school[8] || 0
      school[8] = 0
      fishes[7] = school[7] || 0
      school[7] = fishes[8]
      
      fishes[6] = school[6] || 0
      school[6] = fishes[7]

      fishes[5] = school[5] || 0
      school[5] = fishes[6]
      
      fishes[4] = school[4] || 0
      school[4] = fishes[5]

      fishes[3] = school[3] || 0
      school[3] = fishes[4]
      
      fishes[2] = school[2] || 0
      school[2] = fishes[3]

      fishes[1] = school[1] || 0
      school[1] = fishes[2]
      
      fishes[0] = school[0] || 0
      school[0] = fishes[1]
      school[6] += fishes[0]
      school[8] = fishes[0]
    end

    def time_tick(school)
      new_fish = []
      arr = school.map do |timer|
        if timer == 0
          new_fish << 8
          6
        else
          timer - 1
        end
      end
      [arr, new_fish]
    end
  end
end
