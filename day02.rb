module Day02
  DEPTH_COMMANDS = ['up', 'down']
  HORIZONTAL_COMMANDS = ['forward']

  class << self
    def load_input
      IO.readlines('day02input.txt').map { |line| line.split(' ') }
    end

    def part1
      commands = load_input
      total_depth = 0
      total_horizontal = 0
      commands.each do |command, argument|
        if DEPTH_COMMANDS.include? command
          method_name = interpret_depth_command(command)
          total_depth = total_depth.send(method_name, argument.to_i)
        end

        if HORIZONTAL_COMMANDS.include? command
          method_name = interpret_horizontal_command(command)
          total_horizontal = total_horizontal.send(method_name, argument.to_i)
        end
      end

      return { depth: total_depth, horizontal: total_horizontal, together: total_depth * total_horizontal}
    end

    def part2
      commands = load_input
      total_depth = 0
      total_horizontal = 0
      total_aim = 0

      commands.each do |command, argument|
        if DEPTH_COMMANDS.include? command
          method_name = interpret_depth_command(command)
          total_aim = total_aim.send(method_name, argument.to_i)
        end

        if HORIZONTAL_COMMANDS.include? command
          method_name = interpret_horizontal_command(command)
          total_horizontal = total_horizontal.send(method_name, argument.to_i)
          total_depth = total_depth + total_aim * argument.to_i
        end
      end

      return { depth: total_depth, horizontal: total_horizontal, together: total_depth * total_horizontal}
    end

    def interpret_depth_command(command)
      return :- if command == 'up'
      return :+ if command == 'down'
    end

    def interpret_horizontal_command(command)
      return :+ if command == 'forward'
    end
  end
end