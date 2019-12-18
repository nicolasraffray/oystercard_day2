require 'journeylog.rb'
require 'journey'

describe JourneyLog do
  subject{JourneyLog.new(Journey)}

  describe "#initialize" do
    it "check for journey object" do
      expect(subject.journey_class).is_a?(Journey)
    end
  end

  describe "#start" do
    let(:station){double :station}

    it "takes a start station" do
      expect(subject.instance_variable_get(:@current_journey)).to receive(:start_journey).with(station)
      subject.start(station)
    end
  end

  describe "#finish" do
    let(:station){double :station}
    let(:exit_station){double :exit_station}

    it "takes an end station" do
      expect(subject.instance_variable_get(:@current_journey)).to receive(:end_journey).with(exit_station)
      subject.finish(exit_station)
    end

    it "creates a new journey object at end" do
      subject.start(station)
      expect{subject.finish(station)}.to change{subject.instance_variable_get(:@current_journey).object_id}.from(subject.instance_variable_get(:@current_journey).object_id)
    end
  end

  describe "#make_journey" do
    let(:station){double :station}
    let(:exit_station){double :exit_station}

    it "returns cloned array" do
      subject.start(station)
      subject.finish(exit_station)

      expect{subject.journeys.pop}.not_to change{subject.journey_log}
    end
  end


end
