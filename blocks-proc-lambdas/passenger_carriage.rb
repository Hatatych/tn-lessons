class PassengerCarriage < Carriage
  NO_SEATS = "Недостаточно свободных мест!"
  NEGATIVE_SEATS = "Количество мест не может быть меньше 1!"
  attr_reader :free_seats, :occupied_seats

  def initialize(seats)
    @type = :passenger
    @free_seats = seats
    @occupied_seats = 0
    super()
  end

  def take_seat
    if @free_seats > 0
      @free_seats -= 1
      @occupied_seats += 1
    else
      raise NO_SEATS
    end
  end

  private

  def validate!
    raise NEGATIVE_SEATS unless @free_seats > 0
  end
end
