class Column
  attr_reader :tokens
  def initialize
    @tokens = []
  end

  def place_token(token)
      @tokens << token
  end

  def is_column_full?
    @tokens.count >= 6
  end
end