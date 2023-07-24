class Gameplay
  attr_reader :player1, :player2, :board
  attr_accessor :turn_counter, :current_player

  def initialize
    @player1 = Player.new("x", false)
    @player2 = Player.new("o", true)
    @board = Board.new
    @turn_counter = 0
    @two_players = false
    # @add_names = false
  end

  def start_game
    loop do
      p "Welcome to CONNECT FOUR"
      p "Enter p to play. Enter q to quit."
      input = gets.chomp.downcase
      if input == "p"
        @turn_counter = 0
        @board.columns.clear
        @board.build_board
        @board.update_board
        play
        break
      elsif input == "q"
        exit
      else
        p "Please choose a vailid input."
      end
    end
  end

  def two_players?
    loop do
      p "Play with 2 players?"
      p "Enter y for yes. Enter n for single player."
      input = gets.chomp.downcase
      if input == "y"
        @two_players = true
        @player2.is_computer = false
        add_names?
        break
      elsif input == "n"
        exit
      else
        p "Please choose a vailid input."
      end
    end
  end

  # def add_names?
    
  # end

  def add_player1_name
    if @two_players
      p "Please enter a name for Player 1, keep it clean please"
      input = gets.chomp.downcase
      @player1.add_name(input)
      add_player2_name
      break
    else
      p "Please enter a name for the player, keep it clean please"
      input = gets.chomp.downcase
      @player1.add_name(input)
      break
    end
  end

  def add_player2_name
    p "Please enter a name for Player 2, keep it clean please"
    input = gets.chomp.downcase
    @player2.add_name(input)
    break
  end

  def play
    loop do
      if @turn_counter == 42
        p "The game has ended in a draw."
        start_game
        break
      elsif @board.check_for_win?
        p "#{@current_player} has won!"
        start_game
        break
      elsif @turn_counter < 42
        turn
      end
    end
  end

  def turn
    if @turn_counter.odd?
      @current_player = @player2
    else
      @current_player = @player1
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