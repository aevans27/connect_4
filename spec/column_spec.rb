require 'spec_helper'

RSpec.describe Column do
  before(:each) do
    @column = Column.new
  end

  describe "#initialize" do
    it "can exist and have details" do
      expect(@column).to be_a Column
      expect(@column.tokens).to eq([])
    end
  end

  describe "#place_token" do
    it "can place a token" do
      @column.place_token("x")
      
      expect(@column.tokens).to eq(["x"])
    end
  end
end