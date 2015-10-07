require 'colorize'

class Card
  attr_reader :rank, :suit, :value

    def initialize(rank, suit)
      @rank = rank.to_s.upcase
      @suit = suit
      @value = Card.card_values[rank]
    end

    def self.card_values
      {
        '2' => 2,
        '3' => 3,
        '4' => 4,
        '5' => 5,
        '6' => 6,
        '7' => 7,
        '8' => 8,
        '9' => 9,
        '10' => 10,
        'J' => 11,
        'Q' => 12,
        'K' => 13,
        'A' => 14,
      }
    end

    def <=>(other_card)
      value <=> other_card.value
    end

    def to_s
      suit_colors = {:spades => :black,
                     :clubs => :black,
                     :hearts => :red,
                     :diamonds => :red }
       suit_unicode = {:spades => '♠',
                      :clubs => '♣',
                      :hearts => '♥',
                      :diamonds => '♦' }
      "#{rank}#{suit_unicode[suit]}".colorize(:color => suit_colors[suit])
    end

end
