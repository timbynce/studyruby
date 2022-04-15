class Wagon
  attr_reader :id
  
  def initialize
    @id = rand(1..1000)
  end

  def cargo?
    false
  end

  def passenger?
    false
  end
  
  end
  
  class PassWagon < Wagon
    attr_reader :type, :seats
  
    def initialize
      super
      @type = "passenger"
      @seats = 100
    end

    def passenger?
      true
    end
  end
  
  class CargoWagon < Wagon
    attr_reader :type, :volume
  
    def initialize
      super
      @type = "cargo"
      @volume = 100
    end

    def cargo?
      true
    end
  end
  