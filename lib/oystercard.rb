class Oystercard

  attr_accessor :balance, :in_journey
  attr_reader :deduct

  MAX_CAP = 90
  MIN = 1


  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(money)
    fail "Maximum limit of #{MAX_CAP} reached" if (@balance + money) > MAX_CAP
    @balance += money
  end

  def touch_in
    fail "insufficent funds" if @balance < MIN
    @in_journey = true
  end

  def in_journey?
    @in_journey
  end

  def touch_out
    deduct(MIN)
    @in_journey = false
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end
