class Train
  attr_reader :speed, :carriages, :type # Может возвращать текущую скорость и кол-во вагонов

  def initialize(name, type, carriages) # Название, тип и кол-во вагонов при инициализации
    @name = name
    @type = type
    @carriages = carriages
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

  def add_carriage # Может прицеплять вагон
    @carriages += 1 if speed == 0
  end

  def remove_carriage # Может отцеплять вагон
    @carriages -= 1 if speed == 0 && @carriages > 0
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
