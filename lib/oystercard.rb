class Oystercard

    attr_accessor :balance

    MAX_CAP = 90
    
    def initialize
      @balance = 0
    end

    def top_up(money)
      fail "Maximum limit of #{MAX_CAP} reached" if (@balance + money) > MAX_CAP
      @balance += money
    end

    def pay(fare)
      @balance -= fare
    end

end
