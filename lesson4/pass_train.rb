# frozen_string_literal: true

class PassTrain < Train
  attr_reader :type

  FORMAT = /[a-zA-Z0-9]{3}-?[a-zA-Z0-9]{2}$/.freeze

  validate :num, :format, FORMAT

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
