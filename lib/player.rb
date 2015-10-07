require_relative 'hand'

class Player
  attr_reader :name
  attr_accessor :hand, :folded, :wallet

  def initialize(name = "Player", wallet = 50)
    @name = name
    @wallet = wallet
    @hand = Hand.new
    @folded = false
  end

  def print_cards
    print hand.cards.sort.map {|card| card.to_s }.join(", ")
    puts "."
  end

  def get_bet(previous_bet)
    print_cards
    puts "#{name.capitalize}'s turn."
    puts "Previous bet is #{previous_bet}, match or raise bet, enter 0 to fold."
    input = gets.chomp.to_i
    until input_valid?(input, previous_bet)
      input = gets.chomp.to_i
    end
    self.folded = true if input == 0
    input
  end

  def input_valid?(input, previous_bet)
    return true if input == 0
    return false if input.nil?
    return false if input > wallet || input < previous_bet
    true
  end

  def discard
    print_cards
    puts "which cards would you like to discard? 0-4 Hit enter to not discard."
    discard_indices = gets.chomp.split("").map(&:to_i)
    discard_indices.each do |index|
      @hand.remove_card(index)
    end
    @hand.cards.reject!(&:nil?)
  end

end
