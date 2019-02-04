require_relative './loader.rb'

class Main
  INVALID_INDEX = "Не понятно. Выберите снова"

  def initialize
    @app = App.new
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
      when 1 then @app.create_station
      when 2 then @app.create_train
      when 3 then @app.create_route
      when 4 then @app.add_to_route
      when 5 then @app.delete_from_route
      when 6 then @app.assign_route
      when 7 then @app.add_carriage
      when 8 then @app.remove_carriage
      when 9 then @app.move_train
      when 10 then @app.show_stations
      when 11
        puts "Станции:"
        puts @app.stations
        puts "Маршруты:"
        puts @app.routes
        puts "Поезда:"
        puts @app.trains
        puts "Вагоны:"
        puts @app.carriages
      when 12
        @app.create_carriage
      when 0
        puts "Выходим"
        exit
      else
        puts INVALID_INDEX
      end
    end
  end
end
