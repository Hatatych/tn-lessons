require_relative './loader.rb'

class App
  attr_reader :stations, :routes, :trains

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @carriages = []
  end

  def create_station
    puts "Введите название станции:"
    @stations << Station.new(gets.chomp.capitalize)
  end

  def create_train
    puts "Какой поезд создаем?"
    puts "1. Пассажирский"
    puts "2. Грузовой"
    train_choice = gets.to_i
    puts "Введите название для поезда:"
    case train_choice
    when 1
      @trains << PassengerTrain.new(gets.chomp)
    when 2
      @trains << CargoTrain.new(gets.chomp)
    else
      puts "Не понятно. Возвращение в главное меню"
    end
  end

  def create_carriage
    puts "Какой вагон создаем?"
    puts "1. Пассажирский"
    puts "2. Грузовой"
    carriage_choice = gets.to_i
    case carriage_choice
    when 1
      @carriages << PassengerCarriage.new
    when 2
      @carriages << CargoCarriage.new
    else
      puts "Не понятно. Возвращение в главное меню"
    end
  end

  def find_station_by_name(name)
    @stations.find { |station| station.name == name.capitalize }
  end

  def create_route
    puts "Введите название первой станции"
    first_station = find_station_by_name(gets.chomp)
    puts "Введите название последней станции"
    last_station = find_station_by_name(gets.chomp)
    @routes << Route.new(first_station, last_station)
  end

  def add_to_route
    route_choice = select_route
    puts "Введите название станции, которую добавить:"
    route_choice.add_station(find_station_by_name(gets.chomp))
  end

  def delete_from_route
    route_choice = select_route
    puts "Выберите станцию, которую нужно удалить:"
    route_choice.stations.each_with_index { |station, index| puts "#{index}: #{station.name}" }
    route_choice.delete_station(route_choice.stations[gets.to_i])
  end

  def assign_route
    train_choice = select_train
    route_choice = select_route
    train_choice.assign_route(route_choice)
  end

  def add_carriage
    train_choice = select_train
    carriage_choice = select_carriage
    train_choice.add_carriage(carriage_choice)
  end

  def remove_carriage
    train_choice = select_train
    puts "Выберите вагон, который нужно отцепить:"
    train_choice.carriages.each_with_index { |carriage, index| puts "#{index}: #{carriage}" }
    carriage_choice = train_choice.carriages[gets.to_i]
    train_choice.remove_carriage(carriage_choice)
  end

  def move_train
    train_choice = select_train
    puts "Куда едем?"
    puts "1. Вперед"
    puts "2. Назад"
    direction_choice = gets.to_i
    case direction_choice
    when 1
      train_choice.move_forward
    when 2
      train_choice.move_backwards
    else
      puts "Не понимаю. Возврат в главное меню"
    end
  end

  def show_stations
    @stations.each do |station|
      puts station.name
      puts station.trains unless station.trains.empty?
    end
  end

  private

  def select_route
    puts "Выберите маршрут:"
    @routes.each_with_index { |route, index| puts "#{index}: #{route.stations}" }
    @routes[gets.to_i]
  end

  def select_train
    puts "Выберите поезд:"
    @trains.each_with_index { |train, index| puts "#{index}: #{train}" }
    @trains[gets.to_i]
  end

  def select_carriage
    puts "Выберите вагон:"
    @carriages.each_with_index { |carriage, index| puts "#{index}: #{carriage}" }
    @carriages[gets.to_i]
  end
end
