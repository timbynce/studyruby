# frozen_string_literal: true

class PassTrain < Train
  attr_reader :type

  def initialize(num)
    super

    @type = 'passenger'
    register_instance
  end

  def inspect
    each_wagon do |wagon|
      puts "Wagon ID: #{wagon.id}; TYPE: #{wagon.type}; Total: #{wagon.seats}; Free: #{wagon.free_space}"
    end
  end
end
