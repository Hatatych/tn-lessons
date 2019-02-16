require_relative './manufacturer.rb'
require_relative './instance_counter.rb'
require_relative './validation.rb'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  attr_reader :speed, :carriages, :type, :name

  validate :name, :format, /^[a-z\d]{3}-?[a-z\d]{2}$/i

  @@all_trains = {}

  def self.find(name)
    @@all_trains[name]
  end

  def initialize(name)
    @name = name.to_s
    validate!
    @carriages = []
    stop
    @@all_trains[name] = self
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

  protected

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
