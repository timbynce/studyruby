class Railway
  attr_reader :stations, :routes, :trains, :wagons

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @wagons = []
  end

  # MENU = {
  # "1" => create_station, "2" => create_train, "3" => create_route,
  # "4" => add_station, "5" => remove_station, '6' => set_route,
  # "7" => add_Wagon, "8" => remove_wagon, "9" => move_forward,
  # "10" => move_down, "11" => list_stations, "12" => list_route,
  # "13" => list_trains, "14" => list_wagons, "15" => create_wagon,
  # "16" => take_space_wagon
  # }

  def menu
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

      case choice
      when '1'
        create_station
      when '2'
        create_train
      when '3'
        create_route
      when '4'
        add_station
      when '5'
        remove_station
      when '6'
        set_route
      when '7'
        add_wagon
      when '8'
        remove_wagon
      when '9'
        move_forward
      when '10'
        move_down
      when '11'
        list_stations
      when '12'
        list_route
      when '13'
        list_trains
      when '14'
        list_wagons
      when '15'
        create_wagon
      when '16'
        take_space_wagon
      when 'exit'
        break
      end
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

  # методы, к которым не должно быть доступа пользователя

  def create_station
    puts 'Put the name of station:'
    name = gets.chomp
    Station.new(name)
  rescue StandardError
    puts 'You must type NAME of the station'
  end

  def create_route
    puts 'Put the name of first station'
    first_station = gets.chomp
    puts 'Put the name of end station'
    end_station = gets.chomp
    route = Route.new(station_by_name(first_station), station_by_name(end_station))
    @routes << route
  rescue StandardError => e
    puts 'Error. Put real stations'
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
    puts 'Wrong params. Try again!'
  end

  def remove_station
    puts 'Put index of route'
    route_index = gets.chomp.to_i
    route = @routes[route_index]
    puts 'Put removed station name'
    station_name = gets.chomp
    station = station_by_name(station_name)
    route.remove_station(station)
  rescue StandardError
    puts 'WRONG PARAMS!'
  end

  def create_train
    puts 'Put the type of a train (passenger or cargo):'
    type = gets.chomp
    puts 'Put the number of a train:'
    number = gets.chomp
    if type == 'passenger'
      PassTrain.new(number)
      puts "Train #{number} was created!"
    elsif type == 'cargo'
      CargoTrain.new(number)
      puts "Train #{number} was created!"
    else
      puts 'Wrong train type'
    end
  rescue StandardError
    puts 'Wrong number format'
  end

  def set_route
    puts 'Put the train number'
    tr_num = gets.chomp
    puts 'Put index of route'
    route_index = gets.chomp.to_i
    Train.find_by_num(tr_num).set_route(@routes[route_index])
  rescue StandardError
    puts 'Wrong params. Try again!'
  end

  def add_wagon
    puts 'Put number of train'
    tr_num = gets.chomp
    puts 'Put id of wagon'
    wagon_id = gets.chomp
    Train.find_by_num(tr_num).add_carriage(wagon_by_id(wagon_id.to_i))
  rescue StandardError
    puts 'Wrong params. Try again!'
  end

  def remove_wagon
    puts 'Put number of train'
    tr_num = gets.chomp
    puts 'Put id of wagon for remove'
    wagon_id = gets.chomp.to_i
    Train.find_by_num(tr_num).remove_carriage(wagon_by_id(wagon_id))
  rescue StandardError
    puts 'Wrong params. Try again!'
  end

  def move_forward
    puts 'Put number of train'
    tr_num = gets.chomp
    Train.find_by_num(tr_num).move_forward
  rescue StandardError
    puts "Train doesn't exist!"
  end

  def move_down
    puts 'Put number of train'
    tr_num = gets.chomp
    Train.find_by_num(tr_num).move_down
  rescue StandardError
    puts "Train doesn't exist!"
  end

  def create_wagon
    puts 'Put type of wagon:'
    type = gets.chomp
    puts 'Put id'
    id = gets.chomp
    puts 'Put total seats or volume'
    total = gets.chomp.to_i
    if type == 'passenger'
      @wagons << PassWagon.new(id, total)
    elsif type == 'cargo'
      @wagons << CargoWagon.new(id, total)
    else
      puts 'Wrong type'
    end
  end

  def take_space_wagon
    puts 'Put wagon id'
    wagon_id = gets.chomp
    if wagon_by_id(wagon_id).type == 'cargo'
      wagon_by_id(wagon_id).take_volume
      puts "Successfully take 1 volume in wagon № #{wagon_id}}, free volume: #{wagon_by_id(wagon_id).free_space}"
    else
      wagon_by_id(wagon_id).take_seat
      puts "Successfully take 1 place in wagon № #{wagon_id}, free places: #{wagon_by_id(wagon_id).free_space}"
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
  rescue StandardError
    puts "Route doesn't exist"
  end

  def list_trains
    puts 'Put station name'
    st_name = gets.chomp
    station = station_by_name(st_name)
    puts "List of trains at #{st_name}:"
    station.each_train { |train| puts "#{train.type}; #{train.num}" }
  rescue StandardError
    puts "Stations does'nt exist"
  end

  def list_wagons
    puts 'Put train num'
    tr_num = gets.chomp
    train_type = Train.find_by_num(tr_num).type
    train = Train.find_by_num(tr_num)
    if train_type == 'passenger'
      train.each_wagon do |wagon|
        puts "Wagon ID: #{wagon.id}; TYPE: #{wagon.type}; Total: #{wagon.seats}; Free: #{wagon.free_space}"
      end
    else
      train.each_wagon do |wagon|
        puts "Wagon ID: #{wagon.id}; TYPE: #{wagon.type}; Total: #{wagon.volume}; Free: #{wagon.free_space}"
      end
    end
  end

  # методы для внутренней логики
  protected

  def station_by_name(st_name)
    Station.list_all.find { |st| st.name == st_name }
  end

  def wagon_by_id(wagon_id)
    @wagons.find { |wagon| wagon.id.to_i == wagon_id.to_i }
  end
end
