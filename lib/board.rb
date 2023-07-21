class Board
  attr_reader :columns
  def initialize
    @columns = []
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
        end
      end
      puts row_string
      row_string = ""
      max_index -= 1
    end
  end

end