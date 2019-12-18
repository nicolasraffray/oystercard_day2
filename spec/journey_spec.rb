require 'journey'

describe Journey do
  let(:station){double :station}
  let(:station2){double :station2}

  describe "#initialize" do

    it "gives us a start station" do
      expect(subject.start).to eq nil
    end
  end

  describe "#start_journey" do
    it "sets start station" do
      subject.start_journey(station)
      expect(subject.start).to eq station
    end
  end

  describe "#end_journey" do

    it "sets exit station" do
      subject.end_journey(station2)
      expect(subject.end).to eq station2
    end

    it "checks journey objects being stored" do
      subject.start_journey(station)
      subject.end_journey(station2)
      expect(subject.journey_log).to all(be_a(Journey))
    end
  end

  describe "complete?" do
    it "returns true if journey complete" do
      subject.start_journey(station)
      subject.end_journey(station2)
      expect(subject.complete?).to be(true)

    end

    it "returns false if journey is missing start" do
      subject.end_journey(station2)
      expect(subject.complete?).to be(false)
    end
  end
end
