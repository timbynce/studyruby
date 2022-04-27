class PassWagon < Wagon
  attr_reader :seats

  def initialize(id = rand(1..1000), seats = 100)
    @id = id
    @type = 'passenger'
    @seats = seats
    @taken_seats = 0
  end

  def take_seat
    @taken_seats += 1
  end

  def free_space
    (@seats - @taken_seats)
  end
end
