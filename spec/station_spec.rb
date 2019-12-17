require 'station'

describe Station do

  describe '#initialize' do

    subject{described_class.new( "Bank", 1)}
    # ^these had symbols

    it "gives zone" do
      expect(subject.zone).to eq 1
    end

    it "gives station name" do
      expect(subject.name).to eq "Bank"
    end
  end
end
