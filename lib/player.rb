require_relative 'hand'

class Player
  attr_reader :name, :wallet, :folded
  attr_accessor :hand

  def initialize(name = "Player", wallet = 50)
    @name = name
    @wallet = wallet
    @hand = Hand.new
    @folded = false
  end

  def get_bet(previous_bet)
    puts "Previous bet is #{previous_bet}, match or raise bet, enter 0 to fold."
    input = nil
    until input_valid?(input, previous_bet)
      input = gets.chomp.to_i
    end
    input
  end

  def input_valid?(input, previous_bet)
    return true if input == 0
    return false if input.nil?
    return false if input > wallet || input < previous_bet
  end

  def discard
    puts "which cards would you like to discard? 0-4"
    discard_indices = gets.chomp.split("").map(&:to_i)
    discard_indices.each do |index|
      @hand.delete_at(index)
    end
  end

end
