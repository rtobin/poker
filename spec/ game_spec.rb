require "rspec"
require "game"
#require "deck"

describe Game do
  let(:game) { Game.new() }

  it "doesn't throw error with deck" do
    expect{game.deck}.to_not raise_error
  end

  it ".deck is a deck" do
    expect(game.deck.is_a?(Deck)).to eq(true)
  end

  it "initializes an array for players" do
    expect(game.players.is_a?(Array)).to eq(true)
  end



end
