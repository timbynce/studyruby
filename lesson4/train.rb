class Train    
  attr_reader :speed, :carriage, :num, :route, :current_station, :next_station, :prev_station
  
  def initialize(num = "#{rand(1..1000)}")
    @num = num 
    @carriage = []
    @speed = 0
   
  end

  def add_carriage(wagon)
    return puts "You most stop before change it!" unless @speed == 0
    
    @carriage << wagon
  end

  def remove_carriage(wagon)
    return puts "You must stop before" unless speed == 0
    return puts "No more carriages in train" unless @carriage.length >= 1
    return puts "This wagon is not part of this train" unless @carriage.index(wagon)

    @carriage.delete(wagon)
  end

  def set_route(route)
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
  
protected
#по заданию пользователь не может менять скорость
  def accelerate(speed_change)
    @speed += speed_change if speed_change.positive?
  end

  def slowdown(speed_change)
    @speed -= speed_change if @speed >= 0 && speed_change.positive?
  end

#метод для внутренней логики 
  def check_stations(station)
    @current_station = station
    @next_station = route.next_station_for(station)
    @prev_station = route.prev_station_for(station)
  end
  
end

class PassTrain < Train
  attr_reader :type

  def initialize(num = "#{rand(1..1000)}")
    super
    @type = "passenger"
  end

  def add_carriage(wagon)
    return puts "You can add only passenger wagon!" unless wagon.type == "passenger"
    super
  end

end

class CargoTrain < Train
  attr_reader :type

  def initialize(num = "#{rand(1..1000)}")
    super
    @type = "cargo"
  end

  def add_carriage(wagon)
    return puts "You can add only cargo wagon!" unless wagon.type == "cargo"
    super
  end

end