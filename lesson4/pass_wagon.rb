class PassWagon < Wagon
  attr_reader :seats, :type

  def initialize(id, seats)
    @id = id
    @type = 'passenger'
    @seats = seats
    @taken_seats = 0
  end

  def take_seat
    @taken_seats += 1
  end

  def free_space
    @seats - @taken_seats
  end
end
