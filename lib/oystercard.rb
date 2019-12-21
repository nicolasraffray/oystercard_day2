require_relative 'journey'
require_relative 'journeylog'

class Oystercard

  attr_accessor :balance, :the_journey, :in_journey


  MAX_CAP = 90
  MIN = 1
  PENALTYFARE = 6


  def initialize(balance = 0, the_journey = JourneyLog.new(Journey))
    @balance = balance
    @the_journey = the_journey
    @in_journey = false
  end

  def top_up(money)
    fail "Maximum limit of #{MAX_CAP} reached" if (@balance + money) > MAX_CAP
    @balance += money
  end

  # def touch_in(station = nil )
  #   fail "insufficent funds" if @balance < MIN
  #   deduct(PENALTYFARE) if @in_journey == true
  #   p '-------------------------'
  #   p @the_journey.start(station)
  #   @in_journey = true
  # end

  def touch_in(station)
    deduct(PENALTYFARE) if @in_joureny == true
    min_balance? ? (fail "insufficent funds") : @the_journey.start(station)
    @in_journey = true
  end

  def touch_out(exit_station)
    @the_journey.finish(exit_station)
    deduct(fare)
    @in_joureny = false
  end


  # def touch_out(exit_station = nil)
  #   p @the_journey
  #   @the_journey.start(station) == nil || exit_station == nil ? deduct(PENALTYFARE) : deduct(MIN)
  #   @the_journey.finish(exit_station)
  # end

  private

  def deduct(fare)
    @balance -= fare
  end

  def fare
    @in_journey == true ? MIN : PENALTYFARE
  end

  def min_balance?
    @balance <= MIN
  end
end
