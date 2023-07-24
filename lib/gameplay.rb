class Gameplay
  attr_reader :player1, :player2, :board
  attr_accessor :turn_counter, :current_player

  def initialize
    @player1 = Player.new("x", false)
    @player2 = Player.new("o", true)
    @board = Board.new
    @turn_counter = 0
    @did_start_game = false
  end

  def start_game
    loop do
      p "Welcome to CONNECT FOUR"
      p "Enter p to play. Enter q to quit."
      input = gets.chomp.downcase
      if input == "p"
        if @did_start_game
          prep_and_play
        else
          check_two_players
        end
        break
      elsif input == "q"
        exit
      else
        p "Please choose a vailid input."
      end
    end
  end

  def check_two_players
    loop do
      p "Play with 2 players?"
      p "Enter y for yes. Enter n for single player."
      input = gets.chomp.downcase
      if input == "y"
        @player2.is_computer = false
        add_player1_name
        break
      elsif input == "n"
        @player2.is_computer = true
        add_player1_name
        break
      else
        p "Please choose a vailid input."
      end
    end
  end

  def prep_and_play
    @turn_counter = 0
    @board.columns.clear
    @board.build_board
    @board.update_board
    @did_start_game = true
    play
  end

  def add_player1_name
    loop do
      if @player2.is_computer
        p "Please enter a name for the player, keep it clean please"
        input = gets.chomp.downcase
        if @player1.add_name?(input)
          prep_and_play
          break
        end
      else
        p "Please enter a name for Player 1, keep it clean please"
        input = gets.chomp.downcase
        if @player1.add_name?(input)
          add_player2_name
          break
        end
      end
    end
  end

  def add_player2_name
    loop do
      p "Please enter a name for Player 2, keep it clean please"
      input = gets.chomp.downcase
      if input == @player1.name
        p "Please enter a name different than Player 1"
      elsif @player2.add_name?(input)
        prep_and_play
        break
      end
    end
  end

  def play
    loop do
      if @turn_counter == 42
        p "The game has ended in a draw."
        start_game
        break
      elsif @board.check_for_win?
        p "#{@current_player.name} has won!"
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