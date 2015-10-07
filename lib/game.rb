require "deck"
require "player"

class Game
  attr_reader :deck, :players

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
      current_bet == bet if bet > current_bet
      pot += bet
      #eliminate folded players
    end
  end

  def play_round
    players.each { |player| player.folded = false }
    deck.reset
    deck.shuffle
    active_players.each { |player| deal_to(player) } #$unless player.folded }
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
    winner = players.map { |player| player.hand }.sort.last
    give_pot(winner)
    puts "#{winner.name} won!"
    players.rotate!
  end

  def give_pot(player)
    player.wallet += pot
    pot = 0
  end

  def play

    play_round
  end

  def deal_to(player)
    while player.cards.count < 5
      card = deck.draw
      player.cards << card
  end
end
