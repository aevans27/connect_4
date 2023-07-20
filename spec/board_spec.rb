require 'spec_helper'

RSpec.describe Board do
  describe "#initialize" do
    it "can exist and have details" do
      board = Board.new
      expect(board).to be_a Board
      expect(board.columns).to eq([])

      
    end
  end
end