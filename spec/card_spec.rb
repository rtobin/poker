require "rspec"
require "card"

describe Card do

  let(:card) { Card.new('A', :spade)}
  let(:card2) { Card.new('7', :club)}

  it "has a suit" do
    expect(card.suit).to eq(:spade)
  end

  it "has a rank" do
    expect(card.rank).to eq('A')
  end

  it "has a value" do
    expect(card.value).to eq(14)
  end

  describe "#<=>" do

    it "correctly compares card values" do
      expect(card <=> card2).to eq(1)
    end

  end

end
