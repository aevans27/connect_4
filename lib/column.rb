class Column
  attr_reader :tokens
  def initialize
    @tokens = []
  end

  def place_token(token)
    @tokens << token
  end
end