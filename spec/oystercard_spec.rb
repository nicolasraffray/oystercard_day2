require "oystercard"

describe Oystercard do

  describe "#initialize" do
    it "has a balance of 0 by default" do
      expect(subject.balance).to eq(0)
    end

    it "initializes with empty journeys list" do
      expect(subject.journey_log).to be_empty
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

  describe "PENALTYFARE action" do
    let(:exit_station){double :exit_station}
    let(:station){double :station}

    it  "deducts if no station on touch in" do
      subject.top_up(Oystercard::MIN)
      expect{subject.touch_out(exit_station)}.to change{subject.balance}.by(-Oystercard::PENALTYFARE)
    end

    it "charges penalty fare for no touch out" do
      subject.top_up(Oystercard::MIN)
      subject.touch_in(station)
      expect{subject.touch_out}.to change{subject.balance}.by(-Oystercard::PENALTYFARE)
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
      expect(subject.instance_variable_get(:@current_journey)).to receive(:start_journey).with(station)
      subject.touch_in(station)
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

    it "tells current_journey exit station" do
      expect(subject.instance_variable_get(:@current_journey)).to receive(:end_journey).with(exit_station)
      subject.touch_out(exit_station)
    end
  end
end
