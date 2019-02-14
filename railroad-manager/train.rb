require_relative './manufacturer.rb'
require_relative './instance_counter.rb'

class Train
  include Manufacturer
  include InstanceCounter
  attr_reader :speed, :carriages, :type, :name

  self.class.all_trains = {}
  NAME_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i.freeze
  WRONG_FORMAT = 'Номер имеет недопустимый формат!'.freeze
  NIL_TYPE = 'Не указан тип поезда!'.freeze

  def self.find(name)
    self.class.all_trains[name]
  end

  def initialize(name)
    @name = name.to_s
    validate!
    @carriages = []
    stop
    self.class.all_trains[name] = self
    register_instance
  end

  def each_carriage
    @carriages.each { |carriage| yield carriage }
  end

  def gain_speed(speed_delta)
    @speed += speed_delta if speed_delta > 0
  end

  def lose_speed(speed_delta)
    return unless @speed >= speed_delta && speed_delta > 0

    @speed -= speed_delta
  end

  def stop
    @speed = 0
  end

  def add_carriage(carriage)
    return unless @speed.zero?

    @carriages << carriage if attachable_carriage?(carriage)
  end

  def remove_carriage(carriage)
    @carriages.delete(carriage) if speed.zero? && @carriages.include?(carriage)
  end

  def assign_route(route)
    @route = route
    @at_station = 0
    @route.stations.first.take_train(self)
  end

  def move_forward
    return unless next_station

    current_station.send_train(self)
    next_station.take_train(self)
    @at_station += 1
  end

  def move_backwards
    return unless previous_station

    current_station.send_train(self)
    previous_station.take_train(self)
    @at_station -= 1
  end

  def to_s
    "#{@name}, #{@type}, #{@carriages.length} вагонов"
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise WRONG_FORMAT unless NAME_FORMAT.match? @name
    raise NIL_TYPE if @type.nil?
  end

  def current_station
    @route.current_station(@at_station)
  end

  def next_station
    @route.next_station(@at_station)
  end

  def previous_station
    @route.previous_station(@at_station)
  end
end
