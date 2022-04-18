class Railway
  attr_reader :stations, :routes, :trains, :wagons
 
 def initialize
   @stations = []
   @routes = []
   @trains = []
   @wagons = []
 end
 
 def menu
   loop do
     puts "Choose action:"
     puts "    1 - Create station; 
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
     exit - Exit from program"
     choice = gets.chomp
 
     case choice
     when "1"
       create_station
     when "2"
       create_train
     when "3"
       create_route
     when "4"
       add_station
     when "5"
       remove_station
     when "6"
       set_route
     when "7"
       add_wagon
     when "8"
       remove_wagon
     when "9"
       move_forward
     when "10"
       move_down
     when "11"
       list_stations
     when "12"
       list_route
     when "13"
       list_trains
     when "14"
       list_wagons
     when "exit"
       break
     end
   end
 end
 
 def seed
   @station << Station.new
   @station << Station.new("Moscow")
   @station << Station.new("Prague")
   @routes << Route.new(stations[0], stations[1])
   @trains << PassTrain.new
   @trains << CargoTrain.new
   @wagons << PassWagon.new
   @wagons << PassWagon.new
   @wagons << CargoWagon.new
 end
 
 private
 #методы, к которым не должно быть доступа пользователя
 
 def create_station
   puts "Put the name of station:"
   name = gets.chomp
   Station.new(name)  
 end
 
 def create_train
   puts "Put the type of a train (passenger or cargo):"
   type = gets.chomp
   puts "Put the number of a train:"
   number = gets.chomp
   if type == "passenger"
    PassTrain.new(number)    
   elsif type == "cargo"
    CargoTrain.new(number)    
   else
     puts "Wrong train type"
   end
 end
 
 def create_route
   puts "Put the name of first station"
   first_station = gets.chomp
   puts "Put the name of end station"
   end_station = gets.chomp
   @routes << Route.new(station_by_name(first_station),station_by_name(end_station))
 end
 
 def add_station
   puts "Put index of route"
   route_index = gets.chomp.to_i  
   return puts "Wrong index" unless route_index >=0 && route_index <= @routes.length
   route = @routes[route_index]
   puts "Put the number of added station"
   number_station = gets.chomp.to_i
   puts "Put the Station Name"
   station_name = gets.chomp
   station = station_by_name(station_name)
   return puts "Station doesn't exist" unless station
   return puts "Index cann't be negaive" unless number_station.positive?
   return puts "Station already added to this route" unless route.index_station_for(station) == nil
   if number_station > route.list_stations.length
     puts "Route have only #{route.list_stations.length} stations, so it will added as last!"
     number_station = route.list_stations.length + 1
   end
   route.add_station(station, number_station)
 end
 
 def remove_station
   puts "Put index of route"
   route_index = gets.chomp.to_i
   return puts "Wrong index" unless route_index >=0 && route_index <= @routes.length
   route = @routes[route_index]
   puts "Put removed station name"
   station_name = gets.chomp
   station = station_by_name(station_name) 
   return puts "Station doesn't exist" unless station  
   return puts "Station doesn't added to this route" unless route.index_station_for(station) != nil
   route.remove_station(station)
 end
 
 def set_route
   puts "Put the train number"
   tr_num = gets.chomp
   return puts "Train doesn't exist" unless Train.find_by_num(tr_num)
   puts "Put index of route"
   route_index = gets.chomp.to_i
   return puts "Route doesn't exist" unless @routes[route_index] != nil
   Train.find_by_num(tr_num).set_route(@routes[route_index])
 end
 
 def add_wagon
   puts "Put number of train"
   tr_num = gets.chomp
   return puts "Train doesn't exist" unless Train.find_by_num(tr_num)
   puts "Put id of wagon or RAND if you want to create random wagon"
   wagon_id = gets.chomp
   if wagon_id == "RAND"
     case
     when Train.find_by_num(tr_num).type == "passenger"
       pass_wagon = PassWagon.new
       @wagons << pass_wagon
       Train.find_by_num(tr_num).add_carriage(pass_wagon)
     when Train.find_by_num(tr_num).type == "cargo"
       cargo_wagon = CargoWagon.new
       @wagons << cargo_wagon
       Train.find_by_num(tr_num).add_carriage(cargo_wagon)
     end
   else  
     return puts "Wagon doesn't exist" unless wagon_by_id(wagon_id.to_i)
     Train.find_by_num(tr_num).add_carriage(wagon_by_id(wagon_id.to_i))
   end
 end
 
 def remove_wagon
   puts "Put number of train"
   tr_num = gets.chomp
   return puts "Train doesn't exist" unless Train.find_by_num(tr_num)
   puts "Put id of wagon for remove"
   wagon_id = gets.chomp.to_i
   return puts "Wagon doesn't exist" unless wagon_by_id(wagon_id)
   Train.find_by_num(tr_num).remove_carriage(wagon_by_id(wagon_id))
 end
 
 def move_forward
   puts "Put number of train"
   tr_num = gets.chomp
   return puts "Train doesn't exist" unless Train.find_by_num(tr_num)
   Train.find_by_num(tr_num).move_forward
 end
 
 def move_down
   puts "Put number of train"
   tr_num = gets.chomp
   return puts "Train doesn't exist" unless Train.find_by_num(tr_num)
   Train.find_by_num(tr_num).move_down
 end
 
 def list_stations
   puts "List of all stations:"
   Station.list_all{|st| puts st.name }
 end
 
 def list_route
   puts "Put route index"
   route_index = gets.chomp.to_i
   return puts "Wrong index" unless route_index >=0 && route_index <= @routes.length
   stations = @routes[route_index].list_stations
   puts "Stations of route:"
   stations.each_with_index {|st, index| puts "name: #{st.name}, number: #{index+1}"}
 end
 
 def list_trains
   puts "Put station name"
   st_name = gets.chomp
   return puts "This station doesn't exist" unless station_by_name(st_name)
   puts "List of trains at #{st_name}:"
   st_trains = station_by_name(st_name).list_trains
   st_trains.each{|train| puts "#: #{train.num}, type: #{train.type}"}
 end
 
 def list_wagons
   puts "Put train num"
   tr_num = gets.chomp
   wagons = Train.find_by_num(tr_num).carriage
   wagons.each{|wagon| puts "Wagon ID: #{wagon.id}; TYPE: #{wagon.type}"}
 end
 
 #методы для внутренней логики
 def station_by_name(st_name)
   @stations.find{|st| st.name == st_name}
 end

 def wagon_by_id(wagon_id)
   @wagons.find{|wagon| wagon.id == wagon_id}
 end
 end
 