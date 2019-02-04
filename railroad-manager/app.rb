require_relative './loader.rb'

class App
  attr_reader :stations, :routes, :trains, :carriages

  INVALID_INDEX = "Не понятно. Возвращение в главное меню"

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
    when 1 then @trains << PassengerTrain.new(gets.chomp)
    when 2 then @trains << CargoTrain.new(gets.chomp)
    else puts INVALID_INDEX
    end
  end

  def create_carriage
    puts "Какой вагон создаем?"
    puts "1. Пассажирский"
    puts "2. Грузовой"
    carriage_choice = gets.to_i
    case carriage_choice
    when 1 then @carriages << PassengerCarriage.new
    when 2 then @carriages << CargoCarriage.new
    else puts INVALID_INDEX
    end
  end

  def create_route
    show_array(@stations, "Список станций:")
    puts "Введите индекс первой станции"
    first_station = select_from_array(@stations)
    puts "Введите индекс последней станции"
    last_station = select_from_array(@stations)
    return if first_station.nil? || last_station.nil?
    @routes << Route.new(first_station, last_station)
  end

  def add_to_route
    show_array(@routes, "Выберите маршрут:")
    route_choice = select_from_array(@routes)
    show_array(@stations, "Выберите станцию, которую добавить:")
    return puts INVALID_INDEX if route_choice.nil?
    route_choice.add_station(select_from_array(@stations))
  end

  def delete_from_route
    show_array(@routes, "Выберите маршрут:")
    route_choice = select_from_array(@routes)
    show_array(route_choice.stations, "Выберите станцию, которую удалить")
    route_choice.delete_station(select_from_array(route_choice.stations))
  end

  def assign_route
    show_array(@trains, "Выберите поезд:")
    train_choice = select_from_array(@trains)
    show_array(@routes, "Выберите поезд:")
    route_choice = select_from_array(@routes)
    train_choice.assign_route(route_choice)
  end

  def add_carriage
    show_array(@trains, "Выберите поезд:")
    train_choice = select_from_array(@trains)
    show_array(@carriages, "Выберите вагон:")
    carriage_choice = select_from_array(@carriages)
    train_choice.add_carriage(carriage_choice)
  end

  def remove_carriage
    show_array(@trains, "Выберите поезд:")
    train_choice = select_from_array(@trains)
    show_array(train_choice.carriages, "Выберите вагон, который нужно отцепить:")
    carriage_choice = select_from_array(train_choice.carriages)
    train_choice.remove_carriage(carriage_choice)
  end

  def move_train
    show_array(@trains, "Выберите поезд:")
    train_choice = select_from_array(@trains)
    puts "Куда едем?"
    puts "1. Вперед"
    puts "2. Назад"
    direction_choice = gets.to_i
    case direction_choice
    when 1 then train_choice.move_forward
    when 2 then train_choice.move_backwards
    else puts INVALID_INDEX
    end
  end

  def show_stations
    @stations.each do |station|
      puts station.name
      show_array(station.trains) unless station.trains.empty?
    end
  end

  private

  def show_array(array, title = nil)
    puts title if title
    array.each_with_index do |item, index|
      puts "#{index + 1} — #{item}"
    end
  end

  def select_from_array(array)
    index = gets.to_i
    puts INVALID_INDEX if array[index].nil?
    array[index - 1]
  end
end
