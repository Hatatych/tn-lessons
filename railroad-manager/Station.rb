class Station
  attr_reader :trains, :name # Может возвращать список всех поездов на станции на текущий момент

  def initialize(name)
    @name = name # Имеет название, которое указывается при создании
    @trains = []
  end

  def take_train(train) # Может принимать поезда по одному за раз
    @trains << train
  end

  def trains_by_type(type) # Может возвращать кол-во поездов по типу
    @trains.select { |train| train.type == type }
  end

  def send_train(train) # Может отправлять поезда
    @trains.delete(train)
  end
end
