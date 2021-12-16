class Oystercard
  attr_accessor :balance
  attr_reader :limit, :in_journey, :entry_station, :exit_station, :journey

  DEFAULT_BALANCE = 0
  DEFAULT_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = DEFAULT_BALANCE
    @limit = DEFAULT_LIMIT
    @entry_station = nil
    @exit_station = nil
    @journey = {}
  end

  def top_up(money)
    raise "Max limit of #{@limit} reached" if @balance + money > @limit

    @balance += money
  end

  def in_journey?
    !!in_journey
    # !! converts nil value to true or false
  end

  def touch_in(station)
    raise 'Min balance of £1 required' if balance < MINIMUM_FARE

    @entry_station = station
    @journey[:entry_station] = station
    @in_journey = true
  end

  def touch_out(station)
    deduct(1)
    @exit_station = station
    @in_journey = false
    @journey[:exit_station] = station
  end

  private

  def deduct(money)
    @balance -= money
  end

  
end
