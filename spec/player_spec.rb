require 'spec_helper'

RSpec.describe Player do
  before(:each) do
    @player1 = Player.new("x", false)
    @player2 = Player.new("o", true)
  end

  describe "#initialize" do
    it "can exist and have details" do
      expect(@player1).to be_a Player
      expect(@player1.piece).to eq("x")
    end
  end

  describe "#is_computer" do
    it "knows if it is a computer" do
      expect(@player1.is_computer?).to be false
    end
  end

  describe "#add_name" do
    it "Add names to player" do
      expect(@player1.name).to eq("No name")
      expect(@player1.add_name?("Bob")).to eq(true)
      expect(@player1.name).to eq("Bob")
      expect(@player2.add_name?("")).to eq(false)
    end
  end
end