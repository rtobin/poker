require_relative "deck"
require_relative "player"

class Game
  attr_reader :deck, :players
  attr_accessor :current_bet, :pot

  def initialize(*players)
    @deck = Deck.new
    @players = players
    @pot = 0
    @current_bet = 0
  end

  def current_player
    players.first
  end

  def active_players
    players.reject { |player| player.folded }
  end

  def get_bets
    active_players.each do |player|
      bet = player.get_bet(current_bet)
      self.current_bet = bet if bet > current_bet
      self.pot += bet
    end
  end

  def play_round
    players.each { |player| player.folded = false }
    deck.reset
    deck.shuffle
    active_players.each { |player| deal_to(player) }
    get_bets
    if players.count < 2
      give_pot(players.first)
      return
    end
    active_players.each do |player|
      player.discard
      deal_to(player)
    end
    get_bets
    winner = players.sort_by { |player| player.hand }.last
    give_pot(winner)
    puts "#{winner.name} won!"
    players.rotate!
  end

  def give_pot(player)
    player.wallet += pot
    pot = 0
  end

  def play
    loop do
      play_round
      puts "Play again? y/n"
      break if gets.chomp.downcase == "n"
    end
  end

  def deal_to(player)
    while player.hand.cards.count < 5
      card = deck.draw_card
      player.hand.cards.unshift(card)
    end
  end
end


if $PROGRAM_NAME == __FILE__
  player1 = Player.new("Ryan", 100)
  player2 = Player.new("Fred", 100)
  game = Game.new(player1, player2)
  system("clear")
  game.play
end
