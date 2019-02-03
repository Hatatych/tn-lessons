require_relative './app.rb'

app = App.new

loop do
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
  main_choice = gets.to_i

  case main_choice
  when 1
    app.create_station
  when 2
    app.create_train
  when 3
    app.create_route
  when 4
    app.add_to_route
  when 5
    app.delete_from_route
  when 6
    app.assign_route
  when 7
    app.add_carriage
  when 8
    app.remove_carriage
  when 9
    app.move_train
  when 10
    app.show_stations
  when 11
    puts app.stations
    puts app.routes
    puts app.trains
  when 12
    app.create_carriage
  when 0
    puts "Выходим"
    exit
  else
    puts "Я не понял, выберите из меню"
  end
end
