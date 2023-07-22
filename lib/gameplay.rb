class Gameplay
  attr_reader :player1, :player2, :board
  attr_accessor :turn_counter, :current_player

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

  def play
    loop do
      if @turn_counter == 42
        p "The game has ended in a draw."
        break
      elsif @board.check_for_win?
        p "#{@current_player} has won!"
        break
      elsif @turn_counter < 42
        turn
      end
    end
  end

  def turn
    if @turn_counter == 0 || @turn_counter.even?
      @current_player = @player1
    else
      @current_player = @player2
    end
    
    loop do
      if @current_player.is_computer?
        input = @board.allow_letters.sample
      else
        p "Please select a column to place your piece."
        input = gets.chomp.downcase
      end
    
      if @board.valid_placement?(input)
        selected_index = @board.allow_letters.find_index(input.downcase)
        @board.columns[selected_index].place_token(@current_player.piece)
        @board.update_board
        break
      end
    end

    @turn_counter += 1
  end
end