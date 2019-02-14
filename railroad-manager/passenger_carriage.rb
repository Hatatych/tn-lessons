class PassengerCarriage < Carriage
  attr_reader :free_seats, :occupied_seats

  def initialize(seats)
    @type = :passenger
    super
  end

  def load(_volume = 1)
    super(1)
  end
end
