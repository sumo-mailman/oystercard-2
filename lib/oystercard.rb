require_relative './station'
require_relative './journey'

class Oystercard
  attr_accessor :balance, :new_journey
  attr_reader :limit, :entry_station, :exit_station# :journey_history#, :in_journey

  DEFAULT_BALANCE = 0
  DEFAULT_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = DEFAULT_BALANCE
    @limit = DEFAULT_LIMIT
    @new_journey = Journey.new
    # @journey = {}
    # @journey_history = []
  end

  def top_up(money)
    raise "Max limit of #{@limit} reached" if @balance + money > @limit
    @balance += money
  end

  def in_journey?
    !!entry_station
    # !! converts nil value to true or false
  end

  def touch_in(station)
    raise 'Min balance of £1 required' if balance < MINIMUM_FARE
    @new_journey.journey[:entry_station] = station
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @new_journey.journey[:exit_station] = station
    @new_journey.add_journey
  end

  private

  # def add_journey
  #   @journey_history << @new_journey.journey
  #   @journey, @entry_station, @exit_station = {}, nil, nil
  # end

  def deduct(money)
    @balance -= money
  end

end
