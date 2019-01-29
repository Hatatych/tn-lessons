class Train
  attr_accessor :speed # Может возвращать текущую скорость и набирать ее
  attr_reader :carriages # Может возвращать количество вагонов
  attr_reader :type

  def initialize(name, type, carriages) # Название, тип и кол-во вагонов при инициализации
    @name = name
    @type = type
    @carriages = carriages
  end

  def stop # Может останавливаться
    @speed = 0
  end

  def add_carriage # Может прицеплять вагон
    @carriages += 1 if speed == 0
  end

  def remove_carriage # Может отцеплять вагон
    @carriages -= 1 if speed == 0
  end

  def assign_route(route) # Может принимать маршрут следования
    @route = route
    @at_station = 0
    @route.stations.first.take_train(self) # При назначении маршрута встает на первую станцию
  end

  def move_forward # Может двигаться вперед
    unless @route.stations[@at_station + 1].nil?
      @route.stations[@at_station].send_train(self)
      @at_station += 1
      @route.stations[@at_station].take_train(self)
    end
  end

  def move_backwards # Может двигаться назад
    unless @route.stations[@at_station - 1].nil?
      @route.stations[@at_station].send_train(self)
      @at_station -= 1
      @route.stations[@at_station].take_train(self)
    end
  end

  def announce # Может объявлять станции
    current_station = @route.stations[@at_station]
    puts "Вы сейчас на станции #{current_station.name}"
    unless @route.last_station?(current_station)
      next_station = @route.next_station_name(@at_station)
      puts "Следующая станция: #{next_station}"
    end
    unless @route.first_station?(current_station)
      previous_station = @route.previous_station_name(@at_station)
      puts "Предыдущая станция: #{previous_station}"
    end
  end
end
