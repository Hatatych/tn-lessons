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
    cargo = @trains.select { |train| train.type == type }
  end

  def print_trains_by_type # Печатает кол-во поездов по типу
    types = @trains.map(&:type).uniq
    types.each do |type|
      qty = trains_by_type(type).size
      puts "#{type}: #{qty}"
    end
  end

  def send_train(train) # Может отправлять поезда
    @trains.delete(train)
  end
end
