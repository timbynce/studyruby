class Train    
  include Manufactured
  include InstanceCounter
  attr_reader :speed, :carriage, :num, :route, :current_station, :next_station, :prev_station
  FORMAT = /[a-zA-Z0-9]{3}[-]?[a-zA-Z0-9]{2}$/
  @@all_trains = {}
  def initialize(num = "#{rand(1..1000)}")
    @num = num
    validate! 
    @carriage = []
    @speed = 0
    @@all_trains[num] = self     
  end

  def valid?
      validate!
      true
    rescue
      false
  end

  def self.find_by_num(num)
    @@all_trains[num]
  end


  def add_carriage(wagon)
    return puts "You most stop before change it!" unless @speed == 0
    return puts "Wrong type of wagon!" unless wagon.type == @type
    
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

 def validate!
  raise "Number must be 5 symbols" if num.length < 5
  raise "Number has invalid foramt" if num !~ FORMAT
 end
  
end

class PassTrain < Train
  attr_reader :type

  def initialize(num = "#{rand(1..1000)}")
    super
    @type = "passenger"
    register_instance
  end
end

class CargoTrain < Train
  attr_reader :type

  def initialize(num = "#{rand(1..1000)}")
    super
    @type = "cargo"  
    register_instance  
  end
end
