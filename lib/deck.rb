require_relative 'card'

class Deck

  def self.default_deck
    suits = [:heart, :spade, :club, :diamond]
    ranks = (2..10).to_a.map(&:to_s) + %w[J Q K A]

    suits.each_with_object([]) do |suit, deck|
      ranks.each do |rank|
        deck << Card.new(rank, suit)
      end
    end
  end

  attr_reader :cards

  def initialize
    @cards = Deck.default_deck
  end

  def shuffle
    @cards.shuffle!
  end

  def draw_card
    cards.pop
  end

  def reset
    @cards = Deck.default_deck
  end
end
