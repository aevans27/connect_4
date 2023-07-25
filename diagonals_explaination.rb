def diagonals(grid) #for explaination see below
    (0..grid.size-4).map do |i|
      (0..grid.size-1-i).map do |j| 
        #require 'pry';binding.pry
        grid[i+j].tokens[j] 
      end
    end.concat((1..grid.first.tokens.size-2).map do |j|
      (0..grid.size-j-1).map do |i|
        grid[i].tokens[j+i] 
      end
    end)
  end

  def diagonals_no_tokens(grid)
    (0..grid.size-4).map do |i| #for each value of i, which corresponds to columns a-d, generate a new array
      (0..grid.size-1-i).map do |j| #for each value of j, which corresponds to rows 1-7, generate a new array
        #require 'pry';binding.pry
        grid[i+j][j] #this value is used to populate array. [grid[0+0][0] == A0, grid[0+1][1] == B1...], [grid[1+0][0] == B0, grid[1+1][1] == C1...] until [grid[3+0][0] == D0...]
      end # these steps handle all diagonals starting at row 1
    end.concat((1..grid.first.size-2).map do |j| #for each value of j, which corresponds to rows 2-4, generate a new array
      (0..grid.size-j-1).map do |i| #for each value of i, which corresponds to columns a-f, generate a new array
        grid[i][j+i] #this value is used to populate array. [grid[0][1+0] == A1, grid[1][1+1] == B2...], [grid[0][2+0] == A2, grid[1][2+1] == B3...] until [grid[0][4+0] == A4...]
      end #these steps handle all diagonals starting in column a, and concats them to the previous array
    end)
  end

  def rotate_board_90(grid)
    ncols = grid.first.tokens.size #number of rows, which will correspond to columns when rotated
    #require 'pry';binding.pry
    grid.each_index.with_object([]) do |i,a| #for each index position of grid (column) with an array do a thing
      a << ncols.times.map do |j| #generate a new array a number of times equal to the number of columns when rotated
        # require 'pry';binding.pry
        grid[j].tokens[ncols-1-i] #this value populates the array. [grid[0].tokens[7-1-0] == A7, grid[1].tokens[7-1-0] == B7...], [grid[0].tokens[7-1-1] == A6, grid[1].tokens[7-1-1] == B6...] until [grid[0].tokens[7-1-6] == A0...]
      end
    end
  end

  def antediagonal_win?
    @temp_array.clear #empties temp_array
    p @temp_array #do we need this?
    p @columns #do we need this?
    @temp_array = Marshal.load(Marshal.dump(@columns)) #what is this doing???
    # require 'pry';binding.pry
    @temp_array.each do |col| #for each column do a thing
      p col.tokens #do we need this?
      while col.tokens.count < 7 do #until column is full do a thing. shouldn't this be < 6? the array hasn't been rotated yet, so columns should only hold 6 tokens. could this be replaced with !col.is_column_full? 
        col.place_token(".") #fill column with "."
      end
    end
    rotated_array = rotate_board_90(@temp_array) #defines rotated_array
    arr = diagonals_no_tokens(rotated_array) #defines arr
    four_in_a_row_by_row(arr) #checks for win
  end

  def diagonal_win?
    @temp_array.clear #empties temp_array
    p @temp_array #do we need this?
    @temp_array = Marshal.load(Marshal.dump(@columns)) #what is this doing???
    # require 'pry';binding.pry
    @temp_array.each do |col| #for each column do a thing
      p col.tokens #do we need this?
      while col.tokens.count < 6 do #until column is full do a thing. could this be replaced with !col.is_column_full?
        col.place_token(".") #fill column with "."
      end
    end
    arr = diagonals(@temp_array) #defines arr
    four_in_a_row_by_row(arr) #checks for win
  end

  def four_in_a_row_by_row(arr)
    arr.each do |row| #for each element in the array do a thing
      a = row.each_cons(4).find do |a| #generate new array of each consective sets of 4 if it meets the given criteria
        a.uniq.size == 1 && a.first != '.' #only one unique character && that character isn't "."
      end
      return true unless a.nil? #if a consective set was found that meets criteria i.e. four consecutive "x" or "o" return true       
    end #else move to next element of the array
    false #if no elements of the array have 4 consecutive "x" or "o" return false
  end
end