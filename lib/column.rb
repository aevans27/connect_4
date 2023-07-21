class Column
  attr_reader :tokens
  def initialize
    @tokens = []
  end

  def place_token(token)
    if is_column_full?
      "Please choose a valid column"
    else
      @tokens << token
    end
  end

  def is_column_full?
    @tokens.count >= 6
  end
end