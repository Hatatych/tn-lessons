class Station
  include InstanceCounter
  attr_reader :trains, :name # Может возвращать список всех поездов на станции на текущий момент

  @@all_stations = []
  NAME_FORMAT = /^[a-z]+$/i
  WRONG_FORMAT = "Название может содержать только буквы!"

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name # Имеет название, которое указывается при создании
    validate!
    @trains = []
    @@all_stations << self
    register_instance
  end

  def run_block(&block)
    @trains.each { |train| yield train }
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

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    raise WRONG_FORMAT if @name !~ NAME_FORMAT
  end
end
