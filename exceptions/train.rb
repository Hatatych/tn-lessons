class Train
  include Manufacturer
  include InstanceCounter
  attr_reader :speed, :carriages, :type, :name # Может возвращать текущую скорость и кол-во вагонов

  @@all_trains = {}
  NAME_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i
  NIL_NUMBER = "Номер не может быть пустым!"
  WRONG_LENGTH = "Номер может быть 5 или 6 символов длиной!"
  WRONG_FORMAT = "Номер имеет недопустимый формат!"
  NIL_TYPE = "Не указан тип поезда!"

  def self.find(name)
    @@all_trains[name]
  end

  def initialize(name) # Название, тип и кол-во вагонов при инициализации
    @name = name.to_s
    validate!
    @carriages = []
    stop
    @@all_trains[name] = self
    register_instance
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
    return unless @speed == 0
    @carriages << carriage if attachable_carriage?(carriage)
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

  def to_s
    "#{@name}, #{@type}, #{@carriages.length} вагонов"
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise NIL_NUMBER if @name.nil?
    raise WRONG_LENGTH if @name.length < 5 && @name.length > 6
    raise WRONG_FORMAT if @name !~ NAME_FORMAT
    raise NIL_TYPE if @type.nil?
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
