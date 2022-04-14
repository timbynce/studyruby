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
  #этот метод нужен сугубо для внутренней логики приложени и не используется другими классами. 
  def index_station_for(station)
    @list_stations.index(station)
  end
end

class Wagon
attr_reader :id

def initialize
  @id = rand(1..1000)
end

end

class Pass_Wagon < Wagon
  attr_reader :type, :seats

  def initialize
    super
    @type = "passenger"
    @seats = 100
  end
end

class Cargo_Wagon < Wagon
  attr_reader :type, :volume

  def initialize
    super
    @type = "cargo"
    @volume = 100
  end
end

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
    return puts "No more carriages in train" unless @carriage >= 1
    return puts "This wagon is not part of this train" unless @carriage.index(wagon)

    @carriage = @carriage.delete(wagon)
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

#методы для внутренней логики 
  def check_stations(station)
    @current_station = station
    @next_station = route.next_station_for(station)
    @prev_station = route.prev_station_for(station)
  end

  def validate
    raise "Number must be positive" unless num >= 0    
  end  
  
end

class Pass_Train < Train

  def add_carriage(wagon)
    return puts "You can add only passenger wagon!" unless wagon.type == "passenger"
    super
  end

end

class Cargo_Train < Train

  def add_carriage(wagon)
    return puts "You can add only cargo wagon!" unless wagon.type == "cargo"
    super
  end

end

#Блок проверок всего кошмара
station_1 = Station.new
station_2 = Station.new("Moscow")
station_3 = Station.new("Prague")
route = Route.new(station_1, station_2)
route.add_station(station_3,1)
pass_wag = Pass_Wagon.new
puts pass_wag.id

train_1 = Pass_Train.new
train_2 = Cargo_Train.new
train_1.add_carriage(pass_wag)
train_1.set_route(route)
train_2.set_route(route)
train_1.move_forward
train_1.move_forward
train_1.move_forward
