class Player
  attr_accessor :move, :name
  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Please enter a name."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Choose rock, paper, scissors, lizard or spock  (or r, p, s, l, sp):"
      choice = check_abbreviations(gets.chomp)
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Kernel.const_get(choice.capitalize).new
  end

  def check_abbreviations(choice)
    Move::VALUES.each do |word|
      choice = word if choice == word[0]
    end
    choice = 'spock' if choice == 'sp'
    choice
  end
end

class Computer < Player
  def initialize(history)
    super()
    @history = history
    @fave =
      case name
      when 'Poe' then 'lizard'
      when 'GladOs' then 'spock'
      when 'Elvis' then 'scissors'
      when 'Pachacuti' then 'rock'
      when 'Mary Shelley' then 'paper'
      end
  end

  def set_name
    self.name = ['Poe', 'GladOs', 'Elvis', 'Pachacuti', 'Mary Shelley'].sample
  end

  def choose
    opponent_moves = @history.summary('human').sort_by { |_key, val| val }
    self.move =
      if opponent_moves.empty?
        Kernel.const_get(@fave.capitalize).new
      else
        counter_move(opponent_moves[0][0])
      end
  end

  def counter_move(move)
    case move
    when 'rock' then Paper.new
    when 'paper' then Scissors.new
    when 'scissors' then Spock.new
    when 'lizard' then Rock.new
    when 'spock' then Lizard.new
    end
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def scissors?
    @value == 'scissors'
  end

  def spock?
    @value == 'spock'
  end

  def lizard?
    @value == 'lizard'
  end

  def to_s
    @value
  end
end

class Rock < Move
  def initialize
    @value = 'rock'
  end

  def >(other_move)
    other_move.scissors? || other_move.lizard?
  end

  def <(other_move)
    other_move.paper? || other_move.spock?
  end
end

class Paper < Move
  def initialize
    @value = 'paper'
  end

  def >(other_move)
    other_move.rock? || other_move.spock?
  end

  def <(other_move)
    other_move.scissors? || other_move.lizard?
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
  end

  def >(other_move)
    other_move.paper? || other_move.lizard?
  end

  def <(other_move)
    other_move.rock? || other_move.spock?
  end
end

class Spock < Move
  def initialize
    @value = 'spock'
  end

  def >(other_move)
    other_move.scissors? || other_move.rock?
  end

  def <(other_move)
    other_move.paper? || other_move.lizard?
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
  end

  def >(other_move)
    other_move.paper? || other_move.spock?
  end

  def <(other_move)
    other_move.rock? || other_move.scissors?
  end
end

class Score
  GAME_WINS = 5
  attr_reader :human, :computer
  def reset
    @human = 0
    @computer = 0
  end

  def add_human_point
    @human += 1
  end

  def add_computer_point
    @computer += 1
  end

  def somebody_won?
    @computer == GAME_WINS || @human == GAME_WINS
  end

  def winner
    if @human == GAME_WINS
      'human'
    else
      'computer'
    end
  end
end

class History
  def initialize
    reset
  end

  def reset
    @record = []
  end

  def update(player, computer)
    @record << { player_move: player.to_s,
                 computer_move: computer.to_s }
  end

  def format_line(str1, str2, fill = ' ', edge = '*', width = 12)
    line = edge + fill * (width - str1.length) + str1 + " "
    line + str2 + fill * (width - str2.length) + edge
  end

  def display(name1, name2)
    puts format_line(name1, name2, "-", "+")
    @record.each do |v|
      puts format_line(v[:player_move], v[:computer_move], " ", "|")
    end
    puts format_line('', '', "-", "+")
  end

  def summary(player)
    key = player == "human" ? :player_move : :computer_move
    hash_summary = Hash.new(0)
    @record.each_with_index do |round, idx|
      hash_summary[round[key]] += 1 if idx >= @record.size - 3
    end
    hash_summary
  end
end

class RPSGame
  attr_accessor :human, :computer
  def initialize
    clear_screen
    @history = History.new
    @human = Human.new
    @computer = Computer.new(@history)
    @score = Score.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors #{human.name}!"
  end

  def display_goodbye_message
    puts "Thanks for playing.  Goodbye!"
  end

  def choose_moves
    human.choose
    computer.choose
    clear_screen
  end

  def update_results
    update_score
    @history.update(human.move, computer.move)
  end

  def display_results
    display_moves
    display_winner
    display_score
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def update_score
    if human.move > computer.move
      @score.add_human_point
    elsif human.move < computer.move
      @score.add_computer_point
    end
  end

  def display_score
    puts "#{@human.name}: #{@score.human}"
    puts "#{@computer.name}: #{@score.computer}"
  end

  def display_end_game
    @history.display(@human.name, @computer.name)
    if @score.winner == 'human'
      puts "#{@human.name} Wins the match!"
    else
      puts "#{@computer.name} Wins the match!"
    end
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include? answer
      puts "Please enter y or n."
    end
    answer == 'y'
  end

  def play
    loop do
      @score.reset
      @history.reset
      loop do
        choose_moves
        update_results
        display_results
        break if @score.somebody_won?
      end
      display_end_game
      break unless play_again?
    end
  end
end

game = RPSGame.new
game.display_welcome_message
game.play
game.display_goodbye_message
