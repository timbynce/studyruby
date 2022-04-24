class Wagon
  include Manufactured

  attr_reader :id, :type
  
  def initialize
    @type = "default"
    @id = rand(1..1000)
    self.manufactured = "default corp"
  end
end
 
#мне кажется, что тут валидация нагрузит код. Каждый тип отдельный и с минимальным числом атрибутов. 
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
