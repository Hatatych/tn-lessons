class Station
  attr_reader :trains # Может возвращать список всех поездов на станции на текущий момент
  attr_reader :name

  def initialize(name)
    @name = name # Имеет название, которое указывается при создании
    @trains = []
  end

  def take_train(train) # Может принимать поезда по одному за раз
    @trains << train
  end

  def trains_by_type # Может возвращать кол-во поездов по типу
    cargo = 0
    civil = 0
    @trains.each do |train|
      cargo += 1 if train.type == "cargo"
      civil += 1 if train.type == "civil"
    end
    puts "Грузовых: #{cargo}"
    puts "Пассажирских: #{civil}"
  end

  def send_train(train) # Может отправлять поезда
    @trains.delete(train)
  end
end
