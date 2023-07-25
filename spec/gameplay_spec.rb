require 'spec_helper'

RSpec.describe Gameplay do
  before(:each) do
    @game = Gameplay.new
  end

  describe "#initialize" do
    it "can exist and have details" do
      expect(@game).to be_a Gameplay
      expect(@game.player1).to be_a Player
      expect(@game.player2.piece).to eq("o")
      expect(@game.board).to be_a Board
    end
  end
end