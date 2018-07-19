class Board
  WINNING_LINES =  [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                   [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                   [[1, 5, 9], [3, 5, 7]]
  def initialize
    @squares = {}
    reset
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  # returns winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      markers = Hash.new(0)
      line.each do |square|
        if @squares[square].marker != ' '
          markers[@squares[square].marker] += 1
        end
      end
      markers.each { |key, val| return key if val == 3 }
    end
    nil
  end

  # rubocop:disable Metrics/AbcSize
  def display
    puts "     |     |     "
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}   "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}   "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}   "
    puts "     |     |     "
  end
end
# rubocop:enable Metrics/AbcSize

class Square
  INITIAL_MARKER = ' '
  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker, :name, :type
  def initialize(type)
    @type = type
    choose_name
    pick_marker
  end

  def pick_marker
    if @type == :human
      answer = ''
      loop do
        puts "Please type any single character for your marker:"
        answer = gets.chomp
        break if answer.match? /^[^\s]$/
      end
      @marker = answer
    else
      @marker = %w(X O * @ C !).sample
    end
  end

  def choose_name
    if @type == :human
    answer = ''
      loop do
        puts "Please enter your name:"
        answer = gets.chomp
        break unless answer.empty?
        puts "Sorry, that isn't a valid name."
      end
      @name = answer
    else
      @name = "Johnny"
    end
  end
end

class TTTGame
  #HUMAN_MARKER = 'X'
  #COMPUTER_MARKER = 'O'
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(:human)
    @computer = Player.new(:computer)
  end

  def play
    clear_screen
    display_welcome_message
    #pick markers
    #pick names
    loop do
      display_board
      loop do
        human_moves
        break if board.full? || board.someone_won?
        computer_moves
        break if board.full? || board.someone_won?
        clear_screen_and_display_board
      end
      display_result
      break unless play_again?
      board.reset
      clear_screen
    end
    display_goodbye_message
  end

  private

  def current_player_moves
    if @current == human.marker
      human_moves
      @current_player = computer.marker
    else
      computer_moves
      @current_plauer = human.marker
    end
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing, #{human.name}!"
  end

  def clear_screen
    system('cls') || system('clear')
  end

  def display_board
    puts "#{human.name} is: #{human.marker},  #{computer.name} is: #{computer.marker}"
    board.display
  end

  def clear_screen_and_display_board
    clear_screen
   puts "#{human.name} is: #{human.marker},  #{computer.name} is: #{computer.marker}"
    board.display
  end

  def joinor(array)
    string = '' << array[0].to_s
    (1..array.length-2).each{ |n| string << ", #{array[n]}" }
    string << " or #{array.last}"
  end

  def human_moves
    puts "Choose a square:(#{joinor(board.unmarked_keys)})"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = human.marker
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
  end

  def display_result
    clear_screen
    display_board
    if board.winning_marker == human.marker
      puts "#{human.name} won!"
    elsif board.winning_marker == computer.marker
      puts "#{computer.name} won!"
    elsif board.full?
      puts "The board is full.  It's a tie!"
    end
  end

  def play_again?
    answer = ''
    puts "Play again? (y/n):"
    loop do
      answer = gets.chomp.downcase
      break if ['y', 'n'].include? answer
      puts "Please enter y or n:"
    end
    answer == 'y'
  end
end

TTTGame.new.play
