class Journey
  attr_accessor :journey, :journey_history
  
  def initialize 
    @journey = {}
    @journey_history = []
  end 

  def add_journey
    @journey_history << @journey
    @journey, @entry_station, @exit_station = {}, nil, nil
  end 
end 