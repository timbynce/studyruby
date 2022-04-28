# frozen_string_literal: true

class Station
  attr_reader :name, :list_trains

  def initialize(name = "Station #{rand(1..1000)}")
    @list_trains = []
    @name = name
  end

  def arrival_train(train)
    @list_trains << train
  end

  def departure_train(train)
    @list_trains.delete(train)
  end

  def filter_trains(type = nil)
    @list_trains.select { |train| train.type =~ /#{type}/ }
  end

  def sum_trains(type)
    filter_trains(type).length
  end
end

class Route
  attr_reader :list_stations

  def initialize(start_station, end_station)
    @list_stations = [start_station, end_station]
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

  private

  def index_station_for(station)
    @list_stations.index(station)
  end
end

class Wagon
  attr_reader :wagon_id

  def initialize
    @wagon_id = rand(1..1000)
  end
end

class PassWagon < Wagon
  attr_reader :type

  def initialize
    super
    @type = 'passenger'
  end
end

class CargoWagon < Wagon
  attr_reader :type

  def initialize
    super
    @type = 'cargo'
  end
end

class Train
  TYPES = %w[passenger cargo].freeze
  attr_reader :speed, :carriage, :num, :type, :route, :current_station, :next_station, :prev_station

  def initialize(num = rand(1..1000).to_s, type = 'passenger', carriage = 1)
    @num = num
    @type = type
    @carriage = carriage
    @speed = 0

    validate
  end

  def accelerate(speed_change)
    @speed += speed_change if speed_change.positive?
  end

  def slowdown(speed_change)
    @speed -= speed_change if @speed >= 0 && speed_change.positive?
  end

  def add_carriage
    return puts 'You most stop before change it!' unless @speed.zero?

    @carriage += 1
  end

  def remove_carriage
    return puts 'You must stop before' unless speed.zero?
    return puts 'No more carriages in train' unless @carriage >= 1

    @carriage -= 1
  end

  def to_route(route)
    current_station.departure_train(self) if @current_station
    @route = route
    @current_station = route.list_stations[0]
    @current_station.arrival_train(self)
    check_stations(@current_station)
  end

  def move_forward
    return puts "It's dead end" unless @next_station

    @current_station.departure_train(self)
    check_stations(@next_station)
    @current_station.arrival_train(self)
  end

  def move_down
    return puts "It's dead end" unless @prev_station

    @current_station.departure_train(self)
    check_stations(@prev_station)
    @current_station.arrival_train(self)
  end

  private

  def check_stations(station)
    @current_station = station
    @next_station = route.next_station_for(station)
    @prev_station = route.prev_station_for(station)
  end

  def validate
    raise 'Type missmatch' unless TYPES.include?(type)
    raise 'Carriage number must be positive' unless carriage >= 0
  end
end
