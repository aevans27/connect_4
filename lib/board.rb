class Board
  attr_reader :columns, :allow_letters
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
        p "Selected column is full. Please choose another column"
        false
      else
        true
      end
    else
      p "Input is invalid. Please choose a column from A-G"
      false
    end
  end

  def check_for_win?
    if vertical_win? || horizontal_win? || diagonal_win?
      true
    else
      false
    end
  end

  def vertical_win?
    did_win = false
    @columns.find do |column|
      if !column.tokens.empty?
        if column.tokens.join.downcase.include?("xxxx"||"oooo")
          # require 'pry';binding.pry
          did_win = true
          break
        end
      end
    end
    did_win
  end

  def horizontal_win?
    did_win = false
    max_index = 5
    row_string = ""
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
      if row_string.downcase.include?("xxxx"||"oooo")
        did_win = true
        break
      end
      row_string = ""
      max_index -= 1
    end
    did_win
  end

  def diagonal_win?
    did_win = false
    valid_columns = []
    valid_columns << @columns[0..3]
    require 'pry';binding.pry
    starting_columns = valid_columns.flatten
    # starting_columns == [[@a, @b, @c, @d]]
    starting_index = 0  
    current_index = 0
    diag_string = ""
    while starting_index < 3 do
      current_index = starting_index
      @columns.each do |column|
        if column.tokens.empty?
          diag_string.concat(".")
        else
          if column.tokens[current_index] != nil
            diag_string.concat(column.tokens[current_index])
          else
            diag_string.concat(".")
          end
        end
        current_index += 1
      end
      if diag_string.downcase.include?("xxxx"||"oooo")
        did_win = true
        break
      end
      diag_string = ""
      starting_index += 1
    end
    did_win
  end
end