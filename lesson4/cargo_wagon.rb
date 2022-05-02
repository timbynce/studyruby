# frozen_string_literal: true

class CargoWagon < Wagon
  attr_reader :volume, :type

  def initialize(id, volume)
    super(id)
    
    @type = 'cargo'
    @volume = volume
    @taken_volume = 0
  end

  def take_volume
    @taken_volume += 1
  end

  def free_space
    @volume - @taken_volume
  end
end
