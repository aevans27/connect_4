class Player
  attr_reader :piece, :name
  attr_accessor :is_computer
  def initialize(piece, is_computer)
    @piece = piece
    @is_computer = is_computer
    @name = "No name"
  end

  def is_computer?
    if @is_computer
      @name = "Crow T Robot"
    end
    @is_computer
  end

  def add_name?(name)
    if !name.empty?
      @name = name
      true
    else
      p "Please enter a valid name"
      false
    end
  end

end