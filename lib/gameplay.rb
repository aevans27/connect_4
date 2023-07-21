class Gameplay
  attr_reader :player1, :player2

  def initialize
    @player1 = Player.new("x", false)
    @player2 = Player.new("o", true)
    @board = Board.new
    @board.add_column(@a = Column.new)
    @board.add_column(@b = Column.new)
    @board.add_column(@c = Column.new)
    @board.add_column(@d = Column.new)
    @board.add_column(@e = Column.new)
    @board.add_column(@f = Column.new)
    @board.add_column(@g = Column.new)
    @turn_counter = 0
  end

  def start_game
    p "Welcome to CONNECT FOUR"
    p "Enter p to play. Enter q to quit."
  end

  def turn
    if @turn_counter == 0 || @turn_counter.even?
      player = @player1
    else
      player = @player2
    end
    
    loop do
      if player.computer?
        input = @board.allow_letters.sample
      else
        input = gets.chomp.downcase
      end
    
      if @board.valid_placement?(input)
        selected_index = @allow_letters.find_index(input.downcase)
        @board.columns[selected_index].place_token(player.token)
        @board.update_board
        break
      end
    end

    @turn_counter += 1
  end
end