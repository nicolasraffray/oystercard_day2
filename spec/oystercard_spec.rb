require "oystercard"

describe Oystercard do

  describe "#initialize" do
    it "has a balance of 0 by default" do
      expect(subject.balance).to eq(0)
    end
  end

  describe "#topup" do

    it { is_expected .to respond_to(:top_up).with(1).argument }
    
    it "adds 5 money to the balance" do
      card = Oystercard.new
      card.top_up(5)
      expect(card.balance).to eq(5)

    # expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end
  end
end
