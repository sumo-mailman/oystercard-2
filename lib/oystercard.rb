class Oystercard
  attr_reader :balance, :limit, :in_journey

  DEFAULT_BALANCE = 0
  DEFAULT_LIMIT = 90

  def initialize
    @balance = DEFAULT_BALANCE
    @limit = DEFAULT_LIMIT
  end

  def top_up(money)
    raise "Max limit of #{@limit} reached" if @balance + money > @limit
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end
end

