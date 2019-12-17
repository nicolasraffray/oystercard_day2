require 'journey'

describe Journey do
  let(:station){double :station}
  let(:station2){double :station2}

  describe "#initialize" do

    it "gives us a start station" do
      subject = described_class.new(station)
      expect(subject.start).to eq station
    end
  end

  describe "#end_journey" do

    it "sets exit station" do
      subject = described_class.new(station)
      subject.end_journey(station2)
      expect(subject.end).to eq station2
    end
  end

  describe "complete?" do
    it "returns true if journey complete" do
      subject = described_class.new(station)
      subject.end_journey(station2)

      expect(subject.complete?).to be(true)

    end

    it "returns false if journey is missing start" do
      subject = described_class.new
      subject.end_journey(station2)

      expect(subject.complete?).to be(false)
    end

    it "returns false if journey missing end" do
      subject = described_class.new(station)

      expect(subject.complete?).to be(false)
    end
  end
end
