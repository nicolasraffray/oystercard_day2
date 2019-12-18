class Journey
  attr_reader :start, :end

  def initialize
    @start = nil
    @end = nil
  end

  def start_journey(station)
    @start = station
  end

  def end_journey(station2)
    @end = station2
  end

  def complete?
    !!@start && !!@end
  end
end
