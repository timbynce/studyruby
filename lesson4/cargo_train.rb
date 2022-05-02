# frozen_string_literal: true

class CargoTrain < Train
  attr_reader :type

  def initialize(num)
    super

    @type = 'cargo'
    register_instance
  end

  def inspect
    each_wagon do |wagon|
      puts "Wagon ID: #{wagon.id}; TYPE: #{wagon.type}; Total: #{wagon.volume}; Free: #{wagon.free_space}"
    end
  end
end
