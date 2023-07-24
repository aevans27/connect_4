class Player
  attr_reader :piece, :name
  def initialize(piece, is_computer)
    @piece = piece
    @is_computer = is_computer
    @name = "No name"
  end

  def is_computer?
    @is_computer
  end

  def add_name(name)
    @name = name
  end

end