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
    end
  end
end