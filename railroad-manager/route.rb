class Route
  attr_reader :stations # Может выводить список всех станций

  def initialize(first_station, last_station) # Начальная и конечная станции при инициализации
    @stations = [first_station, last_station]
  end

  def add_station(station) # Может добавлять промежуточную станцию
    @stations.insert(-2, station)
  end

  def delete_station(station) # Может удалять промежуточную станцию
    @stations.delete(station) unless edge_station?(station)
  end

  def next_station(station_index) # Хелперы для возврата названия соседних станций
    @stations[station_index + 1]
  end

  def previous_station(station_index)
    @stations[station_index - 1] if station_index > 0
  end

  def current_station(station_index)
    @stations[station_index]
  end

  def to_s
    "#{@stations.first.name} => #{@stations.last.name}"
  end

  private

  # Все три метода в private, так как являются хелперами, не рекомендуемыми к использованию извне
  def first_station?(station) # Хелперы для определения конечных станций
    @stations.first == station
  end

  def last_station?(station)
    @stations.last == station
  end

  def edge_station?(station) # Хелпер для определения крайности станции
    first_station?(station) || last_station?(station)
  end
end
