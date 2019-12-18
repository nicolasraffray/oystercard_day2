require 'Journey'

class Oystercard

  attr_accessor :balance, :entry_station, :journey_log
  attr_reader :deduct, :current_journey


  MAX_CAP = 90
  MIN = 1
  PENALTYFARE = 6


  def initialize
    @balance = 0
    @journey_log = []
    @current_journey = Journey.new
  end

  def top_up(money)
    fail "Maximum limit of #{MAX_CAP} reached" if (@balance + money) > MAX_CAP
    @balance += money
  end

  def touch_in(station = nil )
    fail "insufficent funds" if @balance < MIN
    @current_journey.start_journey(station)
  end


  def touch_out(exit_station = nil)
    @current_journey.start == nil || exit_station == nil ? deduct(PENALTYFARE) : deduct(MIN)
    @current_journey.end_journey(exit_station)
    reset_log
  end

  private

  def reset_log
    @journey_log << @current_journey
    @current_journey = Journey.new
  end

  def deduct(fare)
    @balance -= fare
  end
end
