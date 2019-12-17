require "oystercard"

describe Oystercard do

  describe "#initialize" do
    it "has a balance of 0 by default" do
      expect(subject.balance).to eq(0)
    end
  end

  describe "#topup" do
    
    context "add money" do
      it { is_expected .to respond_to(:top_up).with(1).argument }
    
      it "adds 5 money to the balance" do
        subject.top_up(5)
        expect(subject.balance).to eq(5)
      # it {expect{ subject.top_up 1 }.to change{ subject.balance }.by 1}
      end

      it "has a limit of 90" do
        max_cap = Oystercard::MAX_CAP
        subject.top_up(max_cap)
        expect { subject.top_up(1) }.to raise_error "Maximum limit of #{max_cap} reached"
      end
    end
  end

  describe "#pay" do
    it { is_expected .to respond_to(:pay).with(1).argument }
    it { expect{ subject.pay(1) }.to change{ subject.balance }.by -1 }
  end

end
