require 'spec_helper'

RSpec.describe Player do
  before(:each) do
    @player1 = Player.new("x")
    @player2 = Player.new("o")
  end

  describe "#initialize" do
    it "can exist and have details" do
      expect(@player1).to be_a Player
      expect(@player1.piece).to eq("x")
    end
  end
end