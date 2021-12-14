class Oystercard
  attr_reader :balance, :limit, :in_journey, :entry_station

  DEFAULT_BALANCE = 0
  DEFAULT_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = DEFAULT_BALANCE
    @limit = DEFAULT_LIMIT
    @entry_station = nil
  end

  def top_up(money)
    raise "Max limit of #{@limit} reached" if @balance + money > @limit
    @balance += money
  end

  def in_journey?
    @in_journey
  end

  def touch_in(station)
    raise "Min balance of £1 required" if balance < MINIMUM_FARE
    @in_journey = true
    return @entry_station = station
    
  end

  def touch_out
    self.deduct(1)
    @in_journey = false
  end

  private

  def deduct(money)
    @balance -= money
  end
end

