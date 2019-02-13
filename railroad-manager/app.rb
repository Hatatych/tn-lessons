require_relative './loader.rb'
require_relative './menus.rb'

class App
  INVALID_INDEX = "Не понятно. Возвращение в главное меню"
  INVALID_MENU = "Не понятно. Выберите снова"
  MOVE_TRAIN_MENU = ["Вперед", "Назад"]
  TYPE_CHOICE = ["Пассажирский", "Грузовой"]
  DATA_EXISTS = "В программе уже есть данные, тестовые не созданы!"

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @carriages = []
  end

  def run
    loop do
      Menus::main_menu
      main_choice = gets.to_i

      case main_choice
      when 1 then station_menu
      when 2 then route_menu
      when 3 then train_menu
      when 4 then carriage_menu
      when 5 then create_test_data
      when 6 then show_stations
      when 0 then abort("Выходим")
      else puts INVALID_MENU
      end
    rescue RuntimeError => e
      show_error e
      retry
    end
  end

  private

  def station_menu
    loop do
      Menus::station_menu
      menu_choice = gets.to_i

      case menu_choice
      when 1 then create_station
      when 2 then add_to_route
      when 3 then delete_from_route
      when 4 then show_trains_on_station
      when 5 then @stations.each { |station| puts station }
      when 0 then break
      else puts INVALID_MENU
      end
    end
  end

  def route_menu
    loop do
      Menus::route_menu
      menu_choice = gets.to_i

      case menu_choice
      when 1 then create_route
      when 2 then @routes.each { |route| puts route }
      when 0 then break
      else puts INVALID_MENU
      end
    end
  end

  def train_menu
    loop do
      Menus::train_menu
      menu_choice = gets.to_i

      case menu_choice
      when 1 then create_train
      when 2 then assign_route
      when 3 then move_train
      when 4 then display_carriages
      when 5 then @trains.each { |train| puts train }
      when 0 then break
      else puts INVALID_MENU
      end
    end
  end

  def carriage_menu
    loop do
      Menus::carriage_menu
      menu_choice = gets.to_i

      case menu_choice
      when 1 then create_carriage
      when 2 then add_carriage
      when 3 then remove_carriage
      when 4 then take_seat_or_load
      when 5 then @carriages.each { |carriage| puts carriage }
      when 0 then break
      else puts INVALID_MENU
      end
    end
  end

  def create_test_data
    if @stations.empty? && @routes.empty? && @trains.empty? && @carriages.empty?
      @stations << Station.new("Pavshino")
      @stations << Station.new("Tushino")
      @stations << Station.new("Dmitrovskaya")
      @routes << Route.new(@stations.first, @stations.last)
      @routes.first.add_station @stations[1]
      @trains << PassengerTrain.new("HTT-01")
      @trains << CargoTrain.new("HTT-02")
      @trains.first.assign_route @routes.first
      @trains.last.assign_route @routes.first
      @carriages << PassengerCarriage.new(20)
      @carriages << PassengerCarriage.new(30)
      @carriages << CargoCarriage.new(400)
      @carriages << CargoCarriage.new(600)
      @trains.first.add_carriage @carriages[0]
      @trains.first.add_carriage @carriages[1]
      @trains.last.add_carriage @carriages[2]
      @trains.last.add_carriage @carriages[3]
      puts
      puts "Данные созданы"
    else
      raise DATA_EXISTS
    end
  end

  def display_carriages
    puts
    show_array(@trains, "Какой поезд выбираем?")
    train_choice = select_from_array(@trains)
    carriages_qty = 0
    train_choice.each_carriage do |carriage|
      carriages_qty += 1
      puts "#{carriages_qty}: #{carriage}, #{carriage.free_volume} свободных мест"
    end
  end

  def show_trains_on_station
    puts
    show_array(@stations, "Выберите станцию:")
    station_choice = select_from_array @stations
    station_choice.each_train { |train| puts train }
  end

  def create_train
    puts
    show_array(TYPE_CHOICE, "Какой поезд создаем?")
    train_choice = gets.to_i
    puts "Введите название для поезда:"
    case train_choice
    when 1 then @trains << PassengerTrain.new(gets.chomp)
    when 2 then @trains << CargoTrain.new(gets.chomp)
    else puts INVALID_INDEX
    end
  rescue RuntimeError => e
    show_error(e)
    retry
  else
    puts "Поезд создан: #{@trains.last}!"
  end

  def show_error(e)
    puts
    puts "Что-то пошло не так, попробуйте снова! Ошибка:"
    puts e.message
  end

  def create_station
    puts
    puts "Введите название станции:"
    @stations << Station.new(gets.chomp.capitalize)
  rescue RuntimeError => e
    show_error(e)
    retry
  else
    puts "Станция создана: #{@stations.last}!"
  end

  def create_carriage
    puts
    show_array(TYPE_CHOICE, "Какой вагон создаем?")
    carriage_choice = gets.to_i
    case carriage_choice
    when 1 then @carriages << PassengerCarriage.new(seats_volume_input("мест"))
    when 2 then @carriages << CargoCarriage.new(seats_volume_input("объем"))
    else puts INVALID_INDEX
    end
  rescue RuntimeError => e
    show_error(e)
    retry
  else
    puts "Вагон создан: #{@carriages.last}!"
  end

  def seats_volume_input(input_title)
    puts
    puts "Сколько #{input_title}?"
    gets.to_i
  end

  def take_seat_or_load
    puts
    show_array(@carriages, "Выберите вагон:")
    carriage = select_from_array(@carriages)
    if carriage.instance_of?(PassengerCarriage)
      carriage.load
    elsif carriage.instance_of?(CargoCarriage)
      puts "Сколько грузим?"
      carriage.load(gets.to_i)
    else puts INVALID_INDEX
    end
    rescue RuntimeError => e
      show_error(e)
  end

  def create_route
    puts
    show_array(@stations, "Список станций:")
    puts "Введите индекс первой станции"
    first_station = select_from_array(@stations)
    puts "Введите индекс последней станции"
    last_station = select_from_array(@stations)
    return if first_station.nil? || last_station.nil?
    @routes << Route.new(first_station, last_station)
  rescue RuntimeError => e
    show_error(e)
    retry
  else
    puts "Маршрут создан: #{@routes.last}!"
  end

  def add_to_route
    puts
    show_array(@routes, "Выберите маршрут:")
    route_choice = select_from_array(@routes)
    show_array(@stations, "Выберите станцию, которую добавить:")
    return puts INVALID_INDEX if route_choice.nil?
    route_choice.add_station(select_from_array(@stations))
  end

  def delete_from_route
    puts
    show_array(@routes, "Выберите маршрут:")
    route_choice = select_from_array(@routes)
    show_array(route_choice.stations, "Выберите станцию, которую удалить")
    station_choice = select_from_array(route_choice.stations)
    route_choice.delete_station(station_choice)
  end

  def assign_route
    puts
    show_array(@trains, "Выберите поезд:")
    train_choice = select_from_array(@trains)
    show_array(@routes, "Выберите поезд:")
    route_choice = select_from_array(@routes)
    train_choice.assign_route(route_choice)
  end

  def add_carriage
    puts
    show_array(@trains, "Выберите поезд:")
    train_choice = select_from_array(@trains)
    show_array(@carriages, "Выберите вагон:")
    carriage_choice = select_from_array(@carriages)
    train_choice.add_carriage(carriage_choice)
  end

  def remove_carriage
    puts
    show_array(@trains, "Выберите поезд:")
    train_choice = select_from_array(@trains)
    show_array(train_choice.carriages, "Выберите вагон, который нужно отцепить:")
    carriage_choice = select_from_array(train_choice.carriages)
    train_choice.remove_carriage(carriage_choice)
  end

  def move_train
    puts
    show_array(@trains, "Выберите поезд:")
    train_choice = select_from_array(@trains)
    show_array(MOVE_TRAIN_MENU, "Куда едем?")
    direction_choice = gets.to_i
    case direction_choice
    when 1 then train_choice.move_forward
    when 2 then train_choice.move_backwards
    else puts INVALID_INDEX
    end
  end

  def show_stations
    puts
    @stations.each do |station|
      puts station.name
      show_array(station.trains) unless station.trains.empty?
    end
  end

  def show_array(array, title = nil)
    puts title if title
    array.each_with_index do |item, index|
      puts "#{index + 1} — #{item}"
    end
  end

  def select_from_array(array)
    index = gets.to_i
    puts INVALID_INDEX if array[index - 1].nil?
    array[index - 1]
  end
end
