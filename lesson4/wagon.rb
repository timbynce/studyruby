class Wagon
  include Manufactured

  attr_reader :id, :type
  
  def initialize
    @type = "default"    
    self.manufactured = "default corp"
  end

end
 
#мне кажется, что тут валидация нагрузит код. Каждый тип отдельный и с минимальным числом атрибутов. 
  class PassWagon < Wagon
    attr_reader :seats
  
    def initialize(id = rand(1..1000),seats = 100)
      @id = id
      @type = "passenger"
      @seats = seats
      @taken_seats = 0
    end

    def take_seat
      @taken_seats += 1
    end

    def free_space
      return (@seats.to_i - @taken_seats).to_i
    end
  end
  
  class CargoWagon < Wagon
    attr_reader :volume
  
    def initialize(id = rand(1..1000),volume = 100)
      @id = id
      @type = "cargo"
      @volume = volume
      @taken_volume = 0
    end

    def take_volume
      @taken_volume += 1
    end

    def free_space
      return (@volume.to_i - @taken_volume.to_i)
    end
  end
