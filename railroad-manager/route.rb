require_relative './instance_counter.rb'

class Route
  include InstanceCounter
  attr_reader :stations

  NIL_STATIONS = 'Начальная или конечная станция маршрута не задана!'.freeze

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
    register_instance
  end

  def each_station
    @stations.each { |station| yield station }
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station) unless edge_station?(station)
  end

  def next_station(station_index)
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

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate!
    raise NIL_STATIONS if @stations.first.nil? || @stations.last.nil?
  end

  def first_station?(station)
    @stations.first == station
  end

  def last_station?(station)
    @stations.last == station
  end

  def edge_station?(station)
    first_station?(station) || last_station?(station)
  end
end
