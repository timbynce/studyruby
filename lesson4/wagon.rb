class Wagon
  attr_reader :id, :type
  
  def initialize
    @type = "default"
    @id = rand(1..1000)
  end
end
  
  class PassWagon < Wagon
    attr_reader :seats
  
    def initialize
      super
      @type = "passenger"
      @seats = 100
    end
  end
  
  class CargoWagon < Wagon
    attr_reader :volume
  
    def initialize
      super
      @type = "cargo"
      @volume = 100
    end
  end
  