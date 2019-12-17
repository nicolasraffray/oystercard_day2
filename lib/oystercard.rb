class Oystercard

  attr_accessor :balance, :entry_station
  attr_reader :deduct


  MAX_CAP = 90
  MIN = 1


  def initialize
    @balance = 0
  end

  def top_up(money)
    fail "Maximum limit of #{MAX_CAP} reached" if (@balance + money) > MAX_CAP
    @balance += money
  end

  def touch_in(station)
    fail "insufficent funds" if @balance < MIN
    @entry_station = station
  end

  def in_journey?
    !!@entry_station
  end

  def touch_out
    deduct(MIN)
    @entry_station = nil
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end
