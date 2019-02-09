class Station
  include InstanceCounter
  attr_reader :trains, :name # Может возвращать список всех поездов на станции на текущий момент

  @@all_stations = []
  # Насчет этого решения я не уверен!
  initialize_counter # инициализация начального значения счетчика экземпляров

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name # Имеет название, которое указывается при создании
    @trains = []
    @@all_stations << self
    register_instance
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

  def to_s
    @name
  end
end
