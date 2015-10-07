require 'rspec'
require 'deck'


describe Deck do
  let(:deck) {Deck.new}

  it "has 52 cards on initially" do
    expect(deck.cards.count).to eq (52)
  end

  describe "#shuffle" do

    it "shuffles deck" do
      expect{deck.shuffle}.to change{deck.cards}
    end
  end

  describe "#draw_card" do
    it "returns a card" do
      expect(deck.draw_card.class).to eq(Card)
    end

    it "removes from deck" do
      orig_size = deck.cards.count
      deck.draw_card
      expect(deck.cards.count).to eq(orig_size - 1)
    end
  end

  describe "#reset" do
    it "returns the deck to a full deck" do
      5.times {deck.draw_card}
      deck.reset
      expect(deck.cards.count).to eq(52)
    end
  end
end
