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

      #@board.update_board
    end
  end

  describe "#add_pieces" do
    it "can add pieces to board" do
      @board.add_column(@a)
      @board.add_column(@b)
      @board.add_column(@c)
      @board.add_column(@d)
      @board.add_column(@e)
      @board.add_column(@f)
      @board.add_column(@g)

      expect(@board.columns).to eq([@a, @b, @c, @d, @e, @f, @g])

      @board.update_board
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

      expect(@board.valid_placement?("c")).to eq(true)
      expect(@board.valid_placement?("z")).to eq(false)
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

      

      # expect(@a.tokens).to eq(["X"])
      @board.update_board
      expect(@board.check_for_win?).to eq(false)
      expect(@board.vertical_win?).to eq(false)
      expect(@board.horizontal_win?).to eq(false)
      expect(@board.diagonal_win?).to eq(false)

      @a.place_token("X")
      @a.place_token("X")
      @a.place_token("X")
      @a.place_token("X")
      
      #expect(@board.check_for_win?).to eq(true)
      expect(@board.vertical_win?).to eq(true)

      
      @b.place_token("X")
      @c.place_token("X")
      @d.place_token("X")

      @b.place_token("X")
      @c.place_token("X")
      @c.place_token("X")
      

      #expect(@board.check_for_win?).to eq(true)
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

  describe "#horizontal_win_possible" do
    it "can tell if a horizontal win is possible starting at column a on this turn" do
      @board.add_column(@a)
      @board.add_column(@b)
      @board.add_column(@c)
      @board.add_column(@d)
      @board.add_column(@e)
      @board.add_column(@f)
      @board.add_column(@g)
      @a.place_token("X")
      @b.place_token("X")

      expect(@board.horizontal_win_possible?).to be false

      @c.place_token("X")

      expect(@board.horizontal_win_possible?).to be true
    end

    it "can tell if a horizontal win is possible ending at column g on this turn" do
      @board.add_column(@a)
      @board.add_column(@b)
      @board.add_column(@c)
      @board.add_column(@d)
      @board.add_column(@e)
      @board.add_column(@f)
      @board.add_column(@g)
      @g.place_token("X")
      @f.place_token("X")

      expect(@board.horizontal_win_possible?).to be false

      @e.place_token("X")

      expect(@board.horizontal_win_possible?).to be true
    end

    it "can tell if a horizontal win is possible in middle columns on this turn" do
      @board.add_column(@a)
      @board.add_column(@b)
      @board.add_column(@c)
      @board.add_column(@d)
      @board.add_column(@e)
      @board.add_column(@f)
      @board.add_column(@g)
      @b.place_token("X")
      @c.place_token("X")

      expect(@board.horizontal_win_possible?).to be false

      @e.place_token("X")

      expect(@board.horizontal_win_possible?).to be true
    end
  end

  describe "#vertical_win_possible" do
    it "can tell if a vertical win is possible on this turn" do
      @board.add_column(@a)
      @board.add_column(@b)
      @board.add_column(@c)
      @board.add_column(@d)
      @board.add_column(@e)
      @board.add_column(@f)
      @board.add_column(@g)
      @a.place_token("X")
      @a.place_token("X")

      expect(@board.vertical_win_possible?).to be false

      @a.place_token("X")

      expect(@board.vertical_win_possible?).to be true

      @a.place_token("O")

      expect(@board.vertical_win_possible?).to be false
    end
  end

  describe "#diagonal_win_possible" do
    it "can tell if a diagonal win is possible" do
      @board.add_column(@a)
      @board.add_column(@b)
      @board.add_column(@c)
      @board.add_column(@d)
      @board.add_column(@e)
      @board.add_column(@f)
      @board.add_column(@g)
      @a.place_token("X")
      @b.place_token("X")
      @b.place_token("X")
      @c.place_token("X")
      @c.place_token("X")
      @d.place_token("X")
      @d.place_token("X")
      @d.place_token("X")
      @e.place_token("O")
      @e.place_token("O")
      @e.place_token("O")
      @e.place_token("O")
      @e.place_token("O")
      @e.place_token("O")

      expect(@board.diagonal_win_possible?).to be false

      @d.place_token("X")

      expect(@board.diagonal_win_possible?).to be true
    end
  end

  describe "#antediagonal_win_possible" do
    it "can tell if an antediagonal win is possible" do
      @board.add_column(@a)
      @board.add_column(@b)
      @board.add_column(@c)
      @board.add_column(@d)
      @board.add_column(@e)
      @board.add_column(@f)
      @board.add_column(@g)
      @b.place_token("X")
      @b.place_token("X")
      @b.place_token("X")
      @c.place_token("X")
      @c.place_token("X")
      @d.place_token("X")
      @d.place_token("X")
      @e.place_token("X")
      @a.place_token("O")
      @a.place_token("O")
      @a.place_token("O")
      @a.place_token("O")
      @a.place_token("O")
      @a.place_token("O")

      expect(@board.antediagonal_win_possible?).to be false

      @c.place_token("X")

      expect(@board.antediagonal_win_possible?).to be true
    end
  end
end