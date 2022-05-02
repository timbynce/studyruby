# frozen_string_literal: true

class Station
  include Validation
  include Accessors
  include InstanceCounter
  attr_reader :name, :list_trains

  validate :name, :presence
  validate :name, :type, String

  def initialize(name)
    @name = name

    validate!

    @list_trains = []
    register_instance
  end

  strong_attr_accessor('postcode', 'String')

  def arrival_train(train)
    @list_trains << train
  end

  def departure_train(train)
    @list_trains.delete(train)
  end

  def filter_trains(type)
    @list_trains.select { |train| train.type =~ /#{type}/ }
  end

  def trains_amount(type)
    filter_trains(type).size
  end

  def each_train(&block)
    @list_trains.each(&block)
  end
end
