class Route
  attr_reader :stations # Может выводить список всех станций

  def initialize(first_station, last_station) # Начальная и конечная станции при инициализации
    @stations = [first_station, last_station]
    @first_station = first_station
    @last_station = last_station
  end

  def add_station(station) # Может добавлять промежуточную станцию
    @stations.insert(-2, station)
  end

  def delete_station(station) # Может удалять промежуточную станцию
    @stations.delete(station) if station != @first_station || station != @last_station
  end

  def first_station?(station) # Хелперы для определения конечных станций
    @first_station == station
  end

  def last_station?(station)
    @last_station == station
  end

  def next_station_name(at_station) # Хелперы для возврата названия соседних станций
    self.stations[at_station + 1].name
  end

  def previous_station_name(at_station)
    self.stations[at_station - 1].name
  end
end
