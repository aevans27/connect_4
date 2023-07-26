require 'spec_helper'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
    @a = Column.new
    @b = Column.new
    @c = Column.new
    @d = Column.new
    @e = Column.new
    @f = Column.new
    @g = Column.new
    @player1 = Player.new("x", false)
    @player2 = Player.new("o", true)
  end

  describe "#initialize" do
    it "can exist and have details" do
      expect(@board).to be_a Board
      expect(@board.columns).to eq([])
    end
  end

  describe "#add_column" do
    it "can add columns" do
      @board.add_column(@a)
      @board.add_column(@b)
      @board.add_column(@c)
      @board.add_column(@d)
      @board.add_column(@e)
      @board.add_column(@f)
      @board.add_column(@g)

      expect(@board.columns).to eq([@a, @b, @c, @d, @e, @f, @g])
    end
  end

  describe "#build_board" do
  it 'can build a board' do
    expect(@board.columns).to eq([])
    @board.build_board
    expect(@board.columns.count).to eq(7)
  end
end

  describe "#update_board" do
    it "can place pieces" do
      @board.add_column(@a)
      @board.add_column(@b)
      @board.add_column(@c)
      @board.add_column(@d)
      @board.add_column(@e)
      @board.add_column(@f)
      @board.add_column(@g)

      @a.place_token("X")

      expect(@a.tokens).to eq(["X"])
      @board.update_board
    end
  end

  describe "#valid_placement" do
    it "is the column selected valid" do
      @board.add_column(@a)
      @board.add_column(@b)
      @board.add_column(@c)
      @board.add_column(@d)
      @board.add_column(@e)
      @board.add_column(@f)
      @board.add_column(@g)

      expect(@board.valid_placement?("c", @player1)).to eq(true)
      expect(@board.valid_placement?("z", @player2)).to eq(false)
    end
  end

  describe "#check_for_win" do
    it "check for conbinations for win" do
      @board.add_column(@a)
      @board.add_column(@b)
      @board.add_column(@c)
      @board.add_column(@d)
      @board.add_column(@e)
      @board.add_column(@f)
      @board.add_column(@g)

      @board.update_board
      expect(@board.check_for_win?).to eq(false)
      expect(@board.vertical_win?).to eq(false)
      expect(@board.horizontal_win?).to eq(false)
      expect(@board.diagonal_win?).to eq(false)

      @a.place_token("X")
      @a.place_token("X")
      @a.place_token("X")
      @a.place_token("X")
      
      expect(@board.check_for_win?).to eq(true)
      expect(@board.vertical_win?).to eq(true)

      @b.place_token("X")
      @c.place_token("X")
      @d.place_token("X")
      @b.place_token("X")
      @c.place_token("X")
      @c.place_token("X")
      
      expect(@board.check_for_win?).to eq(true)
      expect(@board.horizontal_win?).to eq(true)
      expect(@board.diagonal_win?).to eq(false)

      @d.place_token("X")
      @d.place_token("X")
      @d.place_token("X")

      @board.update_board

      expect(@board.diagonal_win?).to eq(true)
      expect(@board.antediagonal_win?).to eq(false)
      @b.place_token("X")
      expect(@board.antediagonal_win?).to eq(true)
      expect(@board.check_for_win?).to eq(true)
    end
  end

  
  describe "diagonals" do
    it "can make return an array of diagonals" do
      @board.add_column(@a)
      @board.add_column(@b)
      @board.add_column(@c)
      @board.add_column(@d)
      @board.add_column(@e)
      @board.add_column(@f)
      @board.add_column(@g)
      
      @a.place_token("X")
      @a.place_token("X")
      @a.place_token("X")
      @a.place_token("X")
      
      expect(@board.diagonals(@board.columns)).to be_a Array
    end
  end
  
  describe "diagonals_no_tokens" do
    it "can make return an array of diagonals" do
      @grid = [["x", "x", "x", "x", ".", "."], [".", ".", ".", ".", ".", "."], [".", ".", ".", ".", ".", "."], [".", ".", ".", ".", ".", "."], [".", ".", ".", ".", ".", "."], [".", ".", ".", ".", ".", "."], [".", ".", ".", ".", ".", "."]]
      expect(@board.diagonals_no_tokens(@grid)).to be_a Array
    end
  end
  
  describe "rotate_board_90" do
    it "can return a rotated array as an array" do
      @board.add_column(@a)
      @board.add_column(@b)
      @board.add_column(@c)
      @board.add_column(@d)
      @board.add_column(@e)
      @board.add_column(@f)
      @board.add_column(@g)
      
      @a.place_token("X")
      @a.place_token("X")
      @a.place_token("X")
      @a.place_token("X")
      
      expect(@board.rotate_board_90(@board.columns)).to be_a Array
    end
  end

  describe "diagonal_array" do
    it "can return a temporary array" do
      @board.add_column(@a)
      @board.add_column(@b)
      @board.add_column(@c)
      @board.add_column(@d)
      @board.add_column(@e)
      @board.add_column(@f)
      @board.add_column(@g)
  
      @a.place_token("X")
      @a.place_token("X")
      @a.place_token("X")
      @a.place_token("X")
  
      expect(@board.diagonal_array).to eq(@board.temp_array)
    end
  end

  describe "four_in_a_row_by_row" do
    it "can tell if an array has four consecutive characters" do
      @grid = [["x", "x", "x", "x", ".", "."], [".", ".", ".", ".", ".", "."], [".", ".", ".", ".", ".", "."], [".", ".", ".", ".", ".", "."], [".", ".", ".", ".", ".", "."], [".", ".", ".", ".", ".", "."], [".", ".", ".", ".", ".", "."]]

      expect(@board.four_in_a_row_by_row(@board.diagonals_no_tokens(@grid))).to be false

      @grid2 = [["x", "x", "x", "x", ".", "."], [".", "x", ".", ".", ".", "."], [".", ".", "x", ".", ".", "."], [".", ".", ".", "x", ".", "."], [".", ".", ".", ".", ".", "."], [".", ".", ".", ".", ".", "."], [".", ".", ".", ".", ".", "."]]

      expect(@board.four_in_a_row_by_row(@board.diagonals_no_tokens(@grid2))).to be true
    end
  end
end