# frozen_string_literal: true

class Route
  include Validation
  include Accessors
  include InstanceCounter
  attr_reader :list_stations, :start_station, :end_station

  attr_accessor_with_history :description

  validate :start_station, :presence
  validate :end_station, :presence

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station   = end_station

    validate!

    @list_stations = [start_station, end_station]
    register_instance
  end

  def add_station(station, index = -2)
    validate_station(station)
    @list_stations.insert(index - 1, station)
  end

  def remove_station(station)
    return if index_station_for(station).nil?

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
    raise 'Wrong station' unless station
  end
end
