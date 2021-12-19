class Station
  attr_reader :recorded_station, :zone
  def initialize(recorded_station, zone)
    @recorded_station = recorded_station
    @zone = zone
  end 
end 
