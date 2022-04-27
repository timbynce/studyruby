class Route
  include InstanceCounter
  attr_reader :list_stations, :start_station, :end_station

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station   = end_station

    validate!

    @list_stations = [start_station, end_station]
    register_instance
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def add_station(station, index = -2)
    validate_station(station)
    @list_stations.insert(index - 1, station)
  end

  def remove_station(station)
    return unless index_station_for(station) != nil

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

  private

  def validate_station(station)
    raise "Wrong station" unless station
  end
  
  def validate!
    raise "Wrong route! Let's try again!" if start_station.nil? || end_station.nil? || start_station == end_station
  end
end
