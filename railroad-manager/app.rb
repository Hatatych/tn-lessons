require_relative './loader.rb'

class App
  INVALID_INDEX = "Не понятно. Возвращение в главное меню"
  INVALID_MENU = "Не понятно. Выберите снова"
  MOVE_TRAIN_MENU = ["Вперед", "Назад"]
  TYPE_CHOICE = ["Пассажирский", "Грузовой"]

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @carriages = []
  end

  def print_menu
    puts "Программа управления железнодорожными путями:"
    puts "1. Создать станцию"
    puts "2. Создать поезд"
    puts "3. Создать новый маршрут"
    puts "4. Добавить станцию в маршрут"
    puts "5. Удалить станцию из маршрута"
    puts "6. Назначать маршрут поезду"
    puts "7. Добавлять вагоны к поезду"
    puts "8. Отцепить вагон от поезда"
    puts "9. Переместить поезд"
    puts "10. Показать список станций и поездов на них"
    puts
    puts "11. Вывести всю имеющуюся инфу"
    puts "12. Создать вагон"
    puts "0. Выйти из программы"
  end

  def run
    loop do
      print_menu
      main_choice = gets.to_i
    
      case main_choice
      when 1 then create_station
      when 2 then create_train
      when 3 then create_route
      when 4 then add_to_route
      when 5 then delete_from_route
      when 6 then assign_route
      when 7 then add_carriage
      when 8 then remove_carriage
      when 9 then move_train
      when 10 then show_stations
      when 12 then create_carriage
      when 0 then abort("Выходим")
      else puts INVALID_MENU
      end
    end
  end

  private

  def create_station
    puts "Введите название станции:"
    @stations << Station.new(gets.chomp.capitalize)
  end

  def create_train
    show_array(TYPE_CHOICE, "Какой поезд создаем?")
    train_choice = gets.to_i
    puts "Введите название для поезда:"
    case train_choice
    when 1 then @trains << PassengerTrain.new(gets.chomp)
    when 2 then @trains << CargoTrain.new(gets.chomp)
    else puts INVALID_INDEX
    end
  end

  def create_carriage
    show_array(TYPE_CHOICE, "Какой вагон создаем?")
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
    station_choice = select_from_array(route_choice.stations)
    route_choice.delete_station(station_choice)
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
    show_array(MOVE_TRAIN_MENU, "Куда едем?")
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
