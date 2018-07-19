class Card
  SUITS = %w(Hearts Diamond Spades Clubs)

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
end