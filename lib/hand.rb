require_relative 'deck'

class Hand
  attr_accessor :cards

  def initialize(cards = [])
    @cards = cards
  end

  def add_card(card)
    assert card.is_a?(Card)
    @cards << card
  end

  def remove_card(index)
    @cards.delete_at(index)
  end

  def royal_flush?
    straight_flush? && highest_card.rank == 'A'
  end

  def straight_flush?
    flush? && straight?
  end

  def full_house?
    of_a_kind?(2) && of_a_kind?(3)
  end

  def flush?
    suit = @cards.first.suit
    @cards.all? { |card| card.suit == suit}
  end

  def straight?
    sorted = @cards.sort
    count = sorted.first.value
    sorted.each do |card|
      return false unless card.value == count
      count +=1
    end
    true
  end

  def rank_freq
    @cards.each_with_object(Hash.new(0)) { |card, hash| hash[card.rank] += 1 }
  end

  def of_a_kind?(num)
    rank_freq.values.include?(num)
  end

  def two_pair?
    rank_freq.values.count(2) == 2
  end

  def highest_card
    @cards.sort.last
  end

  def best_hand
    return 9 if royal_flush?
    return 8 if straight_flush?
    return 7 if of_a_kind?(4)
    return 6 if full_house?
    return 5 if flush?
    return 4 if straight?
    return 3 if of_a_kind?(3)
    return 2 if two_pair?
    return 1 if of_a_kind?(2)
    0
  end

  def <=>(other)
    result = best_hand <=> other.best_hand
    return tie_breaker(other) if result == 0
    result
  end

  def tie_breaker(other) # more logic needed
    highest_card <=> other.highest_card
  end

end


if $PROGRAM_NAME == __FILE__

end
