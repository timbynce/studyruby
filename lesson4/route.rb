class Route  
  include InstanceCounter
  attr_reader :list_stations

  def initialize(start_station, end_station)   
    @list_stations = [start_station, end_station] 
    register_instance
  end

  def add_station(station, index = -2)    
    @list_stations.insert(index - 1, station)   
  end

  def remove_station(station)
    @list_stations.delete(station)
  end
   
  def next_station_for(station)
   return unless @list_stations[-1] != station
   @list_stations[index_station_for(station) + 1]
  end
  
  def prev_station_for(station)
    return unless @list_stations[0] != station
    @list_stations[index_station_for(station) - 1]
  end
  
  def index_station_for(station)
    @list_stations.index(station)
  end
end
