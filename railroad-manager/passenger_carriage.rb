class PassengerCarriage < Carriage
  NO_SEATS = "Недостаточно свободных мест!"
  attr_reader :free_seats, :occupied_seats

  def initialize(seats)
    @type = :passenger
    super
  end

  def load(_volume = 1)
    super(1)
  end
end
