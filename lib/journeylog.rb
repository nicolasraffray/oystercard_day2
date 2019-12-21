
class JourneyLog
  attr_reader :journey_class, :journey_log

  def initialize(journey_class)
    @journey_class = journey_class
    @journey_log = []
    current_journey
  end

  def start(station)
    current_journey.start_journey(station)
  end

  def finish(exit_station)
    current_journey.end_journey(exit_station)
    reset_log
  end

  def journeys
    journey_log.clone
  end

  private

  def reset_log
    @journey_log << @current_journey
    @current_journey = Journey.new
  end

  def current_journey
    @current_journey ||= journey_class.new
  end
end
