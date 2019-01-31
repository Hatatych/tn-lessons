class Train
  attr_reader :speed, :carriages, :type # Может возвращать текущую скорость и кол-во вагонов

  def initialize(name) # Название, тип и кол-во вагонов при инициализации
    @name = name
    @carriages = []
    stop
  end

  def gain_speed(speed_delta)
    @speed += speed_delta if speed_delta > 0
  end

  def lose_speed(speed_delta)
    return unless @speed >= speed_delta && speed_delta > 0
    @speed -= speed_delta
  end

  def stop # Может останавливаться
    @speed = 0
  end

  def add_carriage(carriage) # Может прицеплять вагон
    @carriages << carriage if speed == 0 && @type == carriage.type
  end

  def remove_carriage(carriage) # Может отцеплять вагон
    @carriages.delete(carriage) if speed == 0 && @carriages.include?(carriage)
  end

  def assign_route(route) # Может принимать маршрут следования
    @route = route
    @at_station = 0
    @route.stations.first.take_train(self) # При назначении маршрута встает на первую станцию
  end

  def move_forward # Может двигаться вперед
    return unless next_station
    current_station.send_train(self)
    next_station.take_train(self)
    @at_station += 1
  end

  def move_backwards # Может двигаться назад
    return unless previous_station
    current_station.send_train(self)
    previous_station.take_train(self)
    @at_station -= 1
  end

  protected

  # В протектед так как хелперы используются исключительно внутри объекта
  def current_station
    @route.current_station(@at_station)
  end

  def next_station
    @route.next_station(@at_station)
  end

  def previous_station
    @route.previous_station(@at_station)
  end
end
