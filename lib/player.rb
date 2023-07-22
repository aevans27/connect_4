class Player
  attr_reader :piece
  def initialize(piece, is_computer)
    @piece = piece
    @is_computer = is_computer
  end

  def is_computer?
    @is_computer
  end
end