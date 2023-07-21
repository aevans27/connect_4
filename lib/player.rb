class Player
  attr_reader :piece
  def initialize(piece)
    @piece = piece
    @computer = false
  end

  def computer?
    @computer
  end
end