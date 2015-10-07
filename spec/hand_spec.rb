require "rspec"
require "hand"

describe Hand do

  let(:royal_flush) { Hand.new([
                Card.new('A', :club),
                Card.new('K', :club),
                Card.new('Q', :club),
                Card.new('J', :club),
                Card.new('10', :club)])
                }

  let(:bad_hand) {Hand.new([
                Card.new('2', :club),
                Card.new('3', :diamond),
                Card.new('4', :club),
                Card.new('5', :club),
                Card.new('7', :heart)])
              }
  let(:full_house) {Hand.new([
                Card.new('2', :club),
                Card.new('2', :diamond),
                Card.new('2', :club),
                Card.new('5', :club),
                Card.new('5', :heart)])
                }
  let(:two_pair) {Hand.new([
                Card.new('2', :club),
                Card.new('2', :diamond),
                Card.new('3', :club),
                Card.new('5', :club),
                Card.new('5', :heart)])
                }


  describe "#flush?" do

    it "returns true if all cards of are of same suit" do
      expect(royal_flush.flush?).to eq(true)
    end

    it "returns false if they aren't." do
      expect(bad_hand.flush?).to eq(false)
    end

  end

  describe "#straight?" do

    it "returns true if all cards have consecutive values" do
      expect(royal_flush.straight?).to eq(true)
    end

    it "returns false if they don't." do
      expect(bad_hand.straight?).to eq(false)
    end

  end

  describe "#royal_flush?" do

    it "returns true if hand is a royal_flush" do
      expect(royal_flush.royal_flush?).to eq(true)
    end

    it "returns false if it aren't." do
      expect(bad_hand.royal_flush?).to eq(false)
    end

  end

  describe "#full_house?" do

    it "returns true if hand is a full_house" do
      expect(full_house.full_house?).to eq(true)
    end

    it "returns false if it aren't." do
      expect(bad_hand.full_house?).to eq(false)
    end

  end

  describe "#two_pair?" do

    it "returns true if hand is a two_pair" do
      expect(two_pair.two_pair?).to eq(true)
    end

    it "returns false if it aren't." do
      expect(bad_hand.two_pair?).to eq(false)
    end

  end

  describe "#best_hand" do

    it "recognizes shitty hands" do
      expect(bad_hand.best_hand).to eq(0)
    end

    it "recognizes royal_flush" do
      expect(royal_flush.best_hand).to eq(9)
    end

    it "recognizes full house" do
      expect(full_house.best_hand).to eq(6)
    end
  end

  describe "#<=>" do

    it "correctly ranks hands" do
      sorted_hands = [bad_hand, two_pair, full_house, royal_flush]
      expect(sorted_hands.reverse.sort).to eq(sorted_hands)
    end
    it "breaks ties" do
      bad_hand2 =  Hand.new([
        Card.new('2', :club),
        Card.new('3', :diamond),
        Card.new('4', :club),
        Card.new('6', :club),
        Card.new('8', :heart)])
      expect(bad_hand <=> bad_hand2).to eq(-1)
    end
  end



end
