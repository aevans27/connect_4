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

      @column.place_token("x")
      @column.place_token("x")
      @column.place_token("x")
      @column.place_token("x")
      @column.place_token("x")

      expect(@column.place_token("x")).to eq("Please choose a valid column")
    end
  end

  describe '#column_is_full' do
    it 'check if column is full' do
      @column.tokens << "x"
      @column.tokens << "x"
      @column.tokens << "x"
      @column.tokens << "x"
      @column.tokens << "x"
      @column.tokens << "x"

      expect(@column.is_column_full?).to eq(true)
    end
  end
end