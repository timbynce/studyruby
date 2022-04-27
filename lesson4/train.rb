class Train
  include Manufactured
  include InstanceCounter

  attr_reader :speed, :carriage, :num, :route, :current_station, :next_station, :prev_station

  FORMAT = /[a-zA-Z0-9]{3}-?[a-zA-Z0-9]{2}$/

  @@all_trains = {}

  def self.find_by_num(num)
    @@all_trains[num]
  end

  def initialize(num)
    @num = num
    @carriage = []
    @speed = 0

    validate!

    @@all_trains[num] = self
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def add_carriage(wagon)
    return puts 'You must stop before change it!' unless @speed == 0
    return puts 'Wrong type of wagon!' unless wagon.type == self.type

    @carriage << wagon
  end

  def remove_carriage(wagon)
    return puts 'You must stop before' unless speed == 0
    return puts 'No more carriages in train' unless @carriage.length >= 1
    return puts 'This wagon is not part of this train' unless @carriage.index(wagon)

    @carriage.delete(wagon)
  end

  def set_route(route)
    current_station.departure_train(self) if @current_station
    @route = route
    @current_station = route.list_stations[0]
    @current_station.arrival_train(self)
    update_current_station(@current_station)
  end

  def move_forward
    return puts "It's dead end" unless @next_station

    @current_station.departure_train(self)
    update_current_station(@next_station)
    @current_station.arrival_train(self)
  end

  def move_down
    return puts "It's dead end" unless @prev_station

    @current_station.departure_train(self)
    update_current_station(@prev_station)
    @current_station.arrival_train(self)
  end

  def each_wagon(&block)
    @carriage.each(&block)
  end

  protected

  # по заданию пользователь не может менять скорость
  def accelerate(speed_change)
    @speed += speed_change if speed_change.positive?
  end

  def slowdown(speed_change)
    @speed -= speed_change if @speed >= 0 && speed_change.positive?
  end

  # метод для внутренней логики
  def update_current_station(station)
    @current_station = station
    @next_station = route.next_station_for(station)
    @prev_station = route.prev_station_for(station)
  end

  def validate!
    raise 'Number must be 5 symbols' if num.length < 5
    raise 'Number has invalid foramt' if num !~ FORMAT
  end
end
