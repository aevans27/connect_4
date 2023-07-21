class Board
  attr_reader :columns
  def initialize
    @columns = []
    @allow_letters = ["a", "b", "c", "d", "e", "f", "g"]
  end

  def add_column(column)
    @columns << column
  end

  def welcome
    puts "Welcome to connect 4!
    Player 1 is X and Player 2 is O
    Player 1 goes first!"
  end

  def update_board
    max_index = 5
    row_string = ""
    puts "ABCDEFG"
    while max_index >= 0 do
      @columns.each do |column|
        if column.tokens.empty?
          row_string.concat(".")
        else
          if column.tokens[max_index] != nil
            row_string.concat(column.tokens[max_index])
          else
            row_string.concat(".")
          end
        end
      end
      puts row_string
      row_string = ""
      max_index -= 1
    end
  end

  def valid_placement?(input)
    if "abcdefg".match?(input.downcase)
      selected_index = @allow_letters.find_index(input.downcase)
      if @columns[selected_index].is_column_full?
        p "Seclected column is full. Please choose another column"
        false
      else
        true
      end
    else
      p "Input is invalid. Please choose a column from A-G"
      false
    end

  end

end