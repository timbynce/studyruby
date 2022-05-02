# frozen_string_literal: true

class Wagon
  include Manufactured

  attr_reader :id, :type

  def initialize(id)
    @id = id
    self.manufactured = 'default corp'
  end
end
