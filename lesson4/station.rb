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