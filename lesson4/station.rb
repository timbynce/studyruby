class Station
  include InstanceCounter
  attr_reader :name, :list_trains
  
  @@all_stations = []
  
  def self.list_all
    @@all_stations
  end
    
  def initialize(name)
    @name = name
    validate!    
    @list_trains = []      
    @@all_stations << self    
    register_instance 
  end

  def valid?
    validate!
    true
  rescue
    false
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
  
  def print_trains(lam)
    @list_trains.each do |train|
      lam.call(train)
    end
  end

  private 

  def validate!
    raise "Station must have name" if name.empty?
  end
end
