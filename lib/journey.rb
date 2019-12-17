class Journey
  attr_reader :start, :end

  def initialize(station = nil)
    @start = station

  end

  def end_journey(station2)
    @end = station2
  end

  def complete?
    !!@start && !!@end
  end
end
