class Oystercard

  attr_accessor :balance, :entry_station, :journeys
  attr_reader :deduct


  MAX_CAP = 90
  MIN = 1


  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(money)
    fail "Maximum limit of #{MAX_CAP} reached" if (@balance + money) > MAX_CAP
    @balance += money
  end

  def touch_in(station)
    fail "insufficent funds" if @balance < MIN
    #@entry_station = station
    @journeys << Journey.new(station)
  end

  def in_journey?
    !!@entry_station
  end

  def touch_out(exit_station)
    deduct(MIN)
    # completes journey
    @journeys.push({start: @entry_station, end: exit_station})
    @entry_station = nil
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end
