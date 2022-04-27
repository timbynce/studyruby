class CargoWagon < Wagon
  attr_reader :volume

  def initialize(id = rand(1..1000), volume = 100)
    @id = id
    @type = 'cargo'
    @volume = volume
    @taken_volume = 0
  end

  def take_volume
    @taken_volume += 1
  end

  def free_space
    (@volume - @taken_volume)
  end
end
