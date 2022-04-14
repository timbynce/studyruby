class Wagon
  attr_reader :id
  
  def initialize
    @id = rand(1..1000)
  end
  
  end
  
  class Pass_Wagon < Wagon
    attr_reader :type, :seats
  
    def initialize
      super
      @type = "passenger"
      @seats = 100
    end
  end
  
  class Cargo_Wagon < Wagon
    attr_reader :type, :volume
  
    def initialize
      super
      @type = "cargo"
      @volume = 100
    end
  end
  