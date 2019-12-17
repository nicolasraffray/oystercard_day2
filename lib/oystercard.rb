class Oystercard

  attr_accessor :balance
  attr_accessor :in_journey

  MAX_CAP = 90


  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(money)
    fail "Maximum limit of #{MAX_CAP} reached" if (@balance + money) > MAX_CAP
    @balance += money
  end

  def pay(fare)
    @balance -= fare
  end

  def touch_in
    fail "insufficent funds" if @balance < 1
    @in_journey = true
    @in_journey
  end

  def in_journey?
    @in_journey
  end

  def touch_out
    @in_journey = false
    @in_journey
  end
end
