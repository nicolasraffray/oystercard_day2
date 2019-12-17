require "oystercard"

describe Oystercard do

  describe "#initialize" do
    it "has a balance of 0 by default" do
      expect(subject.balance).to eq(0)
    end

    it "initializes with empty journeys list" do
      expect(subject.journeys).to be_empty
    end
  end

  describe "#topup" do
    it { is_expected .to respond_to(:top_up).with(1).argument }

    it "adds 5 money to the balance" do
      subject.top_up(5)
      expect(subject.balance).to eq(5)
    # it {expect{ subject.top_up 1 }.to change{ subject.balance }.by 1}
    end

    it "has a limit of 90" do
      max_cap = Oystercard::MAX_CAP
      subject.top_up(max_cap)
      expect { subject.top_up(Oystercard::MIN) }.to raise_error "Maximum limit of #{max_cap} reached"
    end
  end

  describe "#touch_in" do
    let(:station){double :station}

    before(:each) do
      subject.top_up(Oystercard::MIN)
      subject.touch_in(station)
    end

    it "raises_error insufficient funds" do
      card = Oystercard.new
      expect { card.touch_in(station) }.to raise_error "insufficent funds"
    end

    it "saves station" do
      expect(subject.entry_station).to eq station
    end

    it "registers start of journey" do
      expect(subject).to be_in_journey
    end
  end

  describe "#touch_out" do
    let(:station){double :station}
    let(:exit_station){double :exit_station}

    before(:each) do
      subject.top_up(Oystercard::MIN)
      subject.touch_in(station)
      subject.touch_out(exit_station)
    end

    it "deducts fare" do
      subject.top_up(20)
      subject.touch_in(station)
      expect{subject.touch_out(exit_station)}.to change{ subject.balance}.by(-Oystercard::MIN)
    end

    it "registers end of journey" do
      expect(subject).to_not be_in_journey
    end

    it 'reset entry station' do
      expect(subject.entry_station).to eq nil
    end

    it "store start and end" do
      expect(subject.journeys).to eq([{start: station, end: exit_station}])
    end
  end

  describe "#in_journey?" do
    let(:station){double :station}
    it "initially not in journey" do
      expect(subject).not_to be_in_journey
    end

    it "returns true when in journey" do
      subject.top_up(Oystercard::MIN)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq true
    end
  end
end
