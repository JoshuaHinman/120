class GuessingGame
  def initialize(low, high)
    @guesses = Math.log2( high - low ).to_i + 1
    @low = low
    @high = high
    @answer = (low..high).to_a.sample
    @player_guess = nil
  end

  def player_move
    loop do
      puts "Enter a number between #{@low} and #{@high}:"
      @player_guess = gets.chomp.to_i
      break if @player_guess > @low - 1 && @player_guess < @high + 1
      puts "#{@player_guess} is not a valid guess"
    end
  end

  def show_guesses_left
    if @guesses > 1
      puts "You have #{@guesses} guesses remaining."
    else
      puts "You have one guess remaining."
    end
  end

  def show_move_result
    if win?
      puts "You won!"
    elsif @player_guess > @answer
      puts "Too high"
    else
      puts "Too low"
    end
  end

  def win?
    @player_guess == @answer
  end

  def play
    while @guesses > 0
      show_guesses_left
      player_move
      show_move_result
      break if win? 
      @guesses -= 1
    end
    puts "You ran out of guesses!" if @guesses == 0
  end

end

GuessingGame.new(500, 100).play