module Day04
  class << self
    def load_input
      input = IO.readlines('day04input.txt', chomp: true)

      draw_numbers = input.delete_at(0).split(',').map(&:to_i)
      acc = []
      current_arr = []
      input.each do |line|
        if line.empty?
          acc << current_arr unless current_arr.empty?
          current_arr = []
        else
          current_arr << line.split(' ').map(&:to_i)
        end
      end
      acc << current_arr
      [draw_numbers, acc]
    end

    def part1
      draw_numbers, boards = load_input
      cards = Array.new(boards.size) { Array.new(boards.first.size) { Array.new(boards.first.first.size) } } 

      winning_board_no = nil
      winning_number = nil

      draw_numbers.each do |number|
        winning_board_no = mark(cards, boards, number).first
        winning_number = number 
        break if winning_board_no
      end

      {
        points: calculate_points(boards[winning_board_no], cards[winning_board_no], winning_number)
      }
    end

    def part2
      draw_numbers, boards = load_input
      cards = Array.new(boards.size) { Array.new(boards.first.size) { Array.new(boards.first.first.size) } } 

      winning_board_numbers = nil
      winning_number = nil
      classification = []
      foo = []

      draw_numbers.each do |number|
        winning_board_numbers = mark(cards, boards, number)
        winning_number = number 

        if winning_board_numbers
          winning_board_numbers.each do |i|
            points = calculate_points(boards[i], cards[i], winning_number)
            classification << { no: i, points: points }
            boards[i] = [[]]
          end
          winning_board_numbers = []
          winning_number = nil
        end
      end

      {
        classification: classification,
        last: classification.last
      }
    end

    def mark(cards, boards, number)
      found = false

      winning_boards = []
      boards.each_with_index do |board, board_no|
        board.each_with_index do |row, i|
          row.each_with_index do |element, j|


            if element == number
              cards[board_no][i][j] = true
              
              if check(cards, board_no, i, j)
                winning_boards << board_no
              end
              found = true
              next if found
            end
          end
          next if found
        end
        found = false
      end

      return winning_boards
    end

    def check(cards, card_no, row, column)
      check_horizontal(cards, card_no, row, column) ||
      check_vertical(cards, card_no, row, column)
    end

    def check_vertical(cards, card_no, row, column)
      cards[card_no].transpose[column].all?
    end

    def check_horizontal(cards, card_no, row, column)
      cards[card_no][row].all?
    end

    def calculate_points(board, card, number)
      points = 0

      board.each_with_index do |row, i|
        row.each_with_index do |el, j|
          points += el unless card[i][j]
        end
      end

      points * number
    end
  end
end
