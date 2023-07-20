require 'spec_helper'

RSpec.describe Column do
  # before(:each) do
  #   @column = Vert.new
  # end

  describe "#initialize" do
    it "can exist and have details" do
      @column = Column.new
      expect(@column).to be_a Column
      expect(@column.tokens).to eq([])
    end
  end
end