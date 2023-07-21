require 'spec_helper'

RSpec.describe Gameplay do
  before(:each) do
    @game = Gameplay.new
    # @board = Board.new
    # @board.add_column(@a = Column.new)
    # @board.add_column(@b = Column.new)
    # @board.add_column(@c = Column.new)
    # @board.add_column(@d = Column.new)
    # @board.add_column(@e = Column.new)
    # @board.add_column(@f = Column.new)
    # @board.add_column(@g = Column.new)
  end

  describe "#initialize" do
    it "can exist and have details" do
      expect(@game).to be_a Gameplay
      # expect(@board.columns).to eq([])
    end
  end

  describe "#welcome" do
    it "default board" do
      # @board.welcome
      # @board.update_board

      # player1 = Player.new("x")
      # player2 = Player.new("o")
      
      expect(@game.start_game).to eq("Enter p to play. Enter q to quit.")
    end
  end

  describe "#turn" do
    it "can accept player column selection" do
      
    end
  end

  # describe "#generate_board" do
  #   it "generates the board" do
  #     expect(@board.columns).to eq([@a, @b, @c, @d, @e, @f, @g])
  #   end
  # end

  # describe "#update_board" do
  #   it "can place pieces" do
  #     @board.add_column(@a)
  #     @board.add_column(@b)
  #     @board.add_column(@c)
  #     @board.add_column(@d)
  #     @board.add_column(@e)
  #     @board.add_column(@f)
  #     @board.add_column(@g)

  #     @a.place_token("X")

  #     expect(@a.tokens).to eq(["X"])
  #     @board.update_board
  #   end
  # end

  # describe "#valid_placement" do
  #   it "is the column selected valid" do
  #     @board.add_column(@a)
  #     @board.add_column(@b)
  #     @board.add_column(@c)
  #     @board.add_column(@d)
  #     @board.add_column(@e)
  #     @board.add_column(@f)
  #     @board.add_column(@g)

  #     expect(@board.valid_placement?("c")).to eq(true)
  #     expect(@board.valid_placement?("z")).to eq(false)
  #   end
  # end
end