require_relative './day01.rb'
require_relative './day02.rb'
require_relative './day03.rb'
require_relative './day04.rb'
require_relative './day05.rb'
require_relative './day06.rb'
require_relative './day07.rb'
require_relative './day08.rb'

highest = :Day01

winner = Module.constants.reduce(Day01) do |winner, current|
  if (current.to_s =~ /Day\d\d/) == 0
    curr_int = current.to_s[3..] || 0
    win_int = winner.to_s[3..]

    if curr_int > win_int
      winner = current
    end
  end

  winner
end

puts "------------------PART 1----------------------"
pp Object.const_get(winner.to_s).part1
puts "----------------------------------------------"
puts "------------------PART 2----------------------"
pp Object.const_get(winner.to_s).part2
puts "----------------------------------------------"