class Board
  attr_reader :columns, :allow_letters
  attr_accessor :temp_array
  def initialize
    @columns = []
    @allow_letters = ["a", "b", "c", "d", "e", "f", "g"]
    @temp_array = []
  end

  def add_column(column)
    @columns << column
  end

  def build_board
    add_column(@a = Column.new)
    add_column(@b = Column.new)
    add_column(@c = Column.new)
    add_column(@d = Column.new)
    add_column(@e = Column.new)
    add_column(@f = Column.new)
    add_column(@g = Column.new)
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

  def valid_placement?(input, player)
    if allow_letters.include?(input.downcase) && !input.empty?
      selected_index = @allow_letters.find_index(input.downcase)
      if @columns[selected_index].is_column_full?
        if !player.is_computer?
          p "Selected column is full. Please choose another column"
        end
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
    if vertical_win? || horizontal_win? || diagonal_win? || antediagonal_win?
      true
    else
      false
    end
  end

  def vertical_win?
    did_win = false
    @columns.find do |column|
      if !column.tokens.empty?
        if column.tokens.join.downcase.include?("xxxx") || column.tokens.join.downcase.include?("oooo")
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
      if row_string.downcase.include?("xxxx") || row_string.downcase.include?("oooo")
        did_win = true
        break
      end
      row_string = ""
      max_index -= 1
    end
    did_win
  end

  def diagonals(grid)
    (0..grid.size-4).map do |column|
      (0..grid.size-1-column).map do |row| 
        grid[column+row].tokens[row] 
      end
    end.concat((1..grid.first.tokens.size-2).map do |row|
      (0..grid.size-row-1).map do |column|
        grid[column].tokens[row+column] 
      end
    end)
  end

  def diagonals_no_tokens(grid)
    (0..grid.size-4).map do |column|
      (0..grid.size-1-column).map do |row|
        grid[column+row][row]
      end
    end.concat((1..grid.first.size-2).map do |row|
      (0..grid.size-row-1).map do |column|
        grid[column][row+column]
      end
    end)
  end

  def rotate_board_90(grid)
    ncols = grid.first.tokens.size
    grid.each_index.with_object([]) do |column_index,column_array|
      column_array << ncols.times.map do |row_index|
        grid[row_index].tokens[ncols-1-column_index]
      end
    end
  end

  def diagonal_array
    @temp_array.clear
    @temp_array = Marshal.load(Marshal.dump(@columns))
    @temp_array.each do |col|
      while col.tokens.count < 6 do
        col.place_token(".")
      end
    end
  end

  def antediagonal_win?
    diagonal_array
    rotated_array = rotate_board_90(@temp_array)
    arr = diagonals_no_tokens(rotated_array)
    four_in_a_row_by_row(arr)
  end

  def diagonal_win?
    diagonal_array
    arr = diagonals(@temp_array)
    four_in_a_row_by_row(arr)
  end

  def four_in_a_row_by_row(arr)
    arr.each do |row|
      a = row.each_cons(4).find do |a|
        a.uniq.size == 1 && a.first != '.'
      end
      return true unless a.nil?  
    end
    false
  end
end