class Railway
  attr_reader :stations, :routes, :trains, :wagons

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @wagons = []
  end

  def menu
    options = {
      '1' => proc { create_station }, '2' => proc { create_train }, '3' => proc { create_route }, 
      '4' => proc { add_station}, '5' => proc { remove_station }, '6' => proc { set_route },
      '7' => proc { add_wagon }, '8' => proc { remove_wagon }, '9' => proc { move_forward },
      '10' => proc { move_down }, '11' => proc { list_stations }, '12' => proc { list_route },
      '13' => proc { list_trains }, '14' => proc { list_wagons }, '15' => proc { create_wagon },
      '16' => proc { take_space_wagon} 
    }
    loop do
      puts 'Choose action:'
      puts "
      1 - Create station;
      2 - Create train;
      3 - Create route;
      4 - Add station to route;
      5 - Remove station from route;
      6 - Set route to train;
      7 - Add wagons to train;
      8 - Remove wagons from train;
      9 - Move train forward;
      10 - Move train down;
      11 - List all stations;
      12 - List stations on the route;
      13 - List trains at the station;
      14 - List wagons of train;
      15 - Create a wagon;
      16 - Take space at wagon;
      exit - Exit from program"
      choice = gets.chomp
      break unless choice != 'exit'
      options[choice].call
    end
  end

  def seed
    @station << Station.new
    @station << Station.new('Moscow')
    @station << Station.new('Prague')

    @routes << Route.new(stations[0], stations[1])

    @trains << PassTrain.new
    @trains << CargoTrain.new

    @wagons << PassWagon.new
    @wagons << PassWagon.new
    @wagons << CargoWagon.new
  end

  private

  def create_station
    puts 'Put the name of station:'
    name = gets.chomp
    Station.new(name)
  rescue StandardError => e
    puts e.message
  end

  def create_route
    puts 'Put the name of first station'
    first_station = gets.chomp

    puts 'Put the name of end station'
    end_station = gets.chomp

    route = Route.new(station_by_name(first_station), station_by_name(end_station))
    @routes << route
  rescue StandardError => e
    puts e.message
  end

  def add_station
    puts 'Put index of route'
    route_index = gets.chomp.to_i
    route = @routes[route_index]

    puts 'Put the number of added station'
    number_station = gets.chomp.to_i

    puts 'Put the Station Name'
    station_name = gets.chomp
    station = station_by_name(station_name)

    number_station = route.list_stations.length + 1 if number_station > route.list_stations.size
    route.add_station(station, number_station)
  rescue StandardError => e
    puts e.message
  end

  def remove_station
    puts 'Put index of route'
    route_index = gets.chomp.to_i
    route = @routes[route_index]

    puts 'Put removed station name'
    station_name = gets.chomp
    station = station_by_name(station_name)

    route.remove_station(station)
  rescue StandardError => e
    puts e.message
  end

  def create_train
    puts 'Put the type of a train (passenger or cargo):'
    type = gets.chomp
    puts 'Put the number of a train:'
    number = gets.chomp
    puts 'Wrong train type' unless ['passenger','cargo'].include? type
    
    case type 
    when 'passenger'
      PassTrain.new(number)      
    when 'cargo'
      CargoTrain.new(number)      
    end

    puts "Train #{number} was created!"
  rescue StandardError => e
    puts e.message
  end

  def set_route
    puts 'Put the train number'
    tr_num = gets.chomp

    puts 'Put index of route'
    route_index = gets.chomp.to_i

    Train.find_by_num(tr_num).set_route(@routes[route_index])
  rescue StandardError => e
    puts e.message
  end

  def add_wagon
    puts 'Put number of train'
    tr_num = gets.chomp
    train = Train.find_by_num(tr_num)
    puts 'Put id of wagon'
    wagon_id = gets.chomp
    wagon = wagon_by_id(wagon_id.to_i)
    
    train.add_carriage(wagon)
  rescue StandardError => e
    puts e.message
  end

  def remove_wagon
    puts 'Put number of train'
    tr_num = gets.chomp

    puts 'Put id of wagon for remove'
    wagon_id = gets.chomp.to_i

    wagon = wagon_by_id(wagon_id)
    Train.find_by_num(tr_num).remove_carriage(wagon)
  rescue StandardError => e
    puts e.message
  end

  def move_forward
    puts 'Put number of train'
    tr_num = gets.chomp
    Train.find_by_num(tr_num).move_forward
  rescue StandardError => e
    puts e.message
  end

  def move_down
    puts 'Put number of train'
    tr_num = gets.chomp
    Train.find_by_num(tr_num).move_down
  rescue StandardError => e
    puts e.message
  end

  def create_wagon
    puts 'Put type of wagon:'
    type = gets.chomp
    return 'Wrong type' unless ['cargo','passenger'].include? type
    
    puts 'Put id'
    id = gets.chomp

    puts 'Put total seats or volume'
    total = gets.chomp.to_i

    case type
    when 'passenger'
      @wagons << PassWagon.new(id, total)
    when 'cargo'
      @wagons << CargoWagon.new(id, total)
    end
  end

  def take_space_wagon
    puts 'Put wagon id'
    wagon_id = gets.chomp
    wagon = wagon_by_id(wagon_id)

    if wagon.type == 'cargo'
      wagon.take_volume
      puts "Successfully take 1 volume in wagon № #{wagon_id}}, free volume: #{wagon.free_space}"
    else
      wagon.take_seat
      puts "Successfully take 1 place in wagon № #{wagon_id}, free places: #{wagon.free_space}"
    end
  end

  def list_stations
    puts 'List of all stations:'
    stations = Station.list_all
    stations.each { |st| puts st.name }
  end

  def list_route
    puts 'Put route index'
    route_index = gets.chomp.to_i
    stations = @routes[route_index].list_stations    

    puts 'Stations of route:'
    stations.each_with_index { |st, index| puts "name: #{st.name}, number: #{index + 1}" }
  rescue StandardError => e
    puts e.message
  end

  def list_trains
    puts 'Put station name'
    st_name = gets.chomp
    station = station_by_name(st_name)

    puts "List of trains at #{st_name}:"
    station.each_train { |train| puts "#{train.type}; #{train.num}" }
  rescue StandardError => e
    puts e.message
  end

  def list_wagons
    puts 'Put train num'
    tr_num = gets.chomp
    train = Train.find_by_num(tr_num)
    train.inspect
  end

  def station_by_name(st_name)
    Station.list_all.find { |st| st.name == st_name }
  end

  def wagon_by_id(wagon_id)
    @wagons.find { |wagon| wagon.id.to_i == wagon_id.to_i }
  end
end
