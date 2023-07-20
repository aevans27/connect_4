class Board
  attr_reader :columns
  def initialize
    @columns = []
  end

  def add_column(column)
    @columns << column
  end
end