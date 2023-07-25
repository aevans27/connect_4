class Gameplay
  attr_reader :player1, :player2, :board
  attr_accessor :turn_counter, :current_player, :next_player, :column_index, :comp_input, :index_to_place

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
        replay
        if @did_start_game
          prep_and_play
        else
          check_two_players
        end
        break
      elsif @board.check_for_win?
        p "#{@current_player.name} has won!"
        replay
        if @did_start_game
          prep_and_play
        else
          check_two_players
        end
        break
      elsif @turn_counter < 42
        turn
      end
    end
  end

  def turn
    if @turn_counter.odd?
      @current_player = @player2
      @next_player = @player1
    else
      @current_player = @player1
      @next_player = @player2
    end
    
    loop do
      if @current_player.is_computer?
        input = smart_comp
      else
        p "Please select a column to place your piece."
        input = gets.chomp.downcase
      end
    
      if @board.valid_placement?(input, @current_player)
        selected_index = @board.allow_letters.find_index(input.downcase)
        @board.columns[selected_index].place_token(@current_player.piece)
        @board.update_board
        break
      end
    end

    @turn_counter += 1
  end

  def replay
    p "Would you like to play again? P to play again, Q to quit."
    loop do
      input1 = gets.chomp.downcase
      if input1 == "p"
        p "Would you like a rematch or new players? R for rematch, N for new players."
        loop do
          input2 = gets.chomp.downcase
          if input2 == "n"
            @did_start_game = false
            break
          elsif input2 != "r"
            p "Input is invalid. R for rematch, N for new players."
          else
            break
          end
        end
        break
      elsif input1 != "q"
        p "Input is invalid. P to play again, Q to quit."
      else
        exit
      end
    end
  end

  def smart_comp
    if can_win?(@current_player)
      @comp_input
    elsif can_win?(@next_player)
      @comp_input
    else
      @board.allow_letters.sample
    end
  end

  def index_to_input(index)
    if index == 0
      "a"
    elsif index == 1
      "b"
    elsif index == 2
      "c"
    elsif index == 3
      "d"
    elsif index == 4
      "e"
    elsif index == 5
      "f"
    elsif index == 6
      "g"
    end
  end

  def can_win?(player)
    @board_dup = Marshal.load(Marshal.dump(@board))

    @index_to_place = @board_dup.columns.find_index do |column|
      column.place_token(player.piece) unless column.is_column_full?
      if @board_dup.check_for_win?
        true
      else
        column.tokens.pop
        false
      end
    end

    if !@index_to_place.nil?
      @comp_input = index_to_input(@index_to_place)
      true
    else
      false
    end
  end
end