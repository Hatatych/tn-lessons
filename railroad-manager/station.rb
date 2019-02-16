require_relative './instance_counter.rb'
require_relative './validation.rb'

class Station
  include InstanceCounter
  include Validation

  attr_reader :trains, :name

  validate :name, :format, /^[a-z]+$/i

  @@all_stations = []

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name.capitalize
    validate!
    @trains = []
    @@all_stations << self
    register_instance
  end

  def each_train
    @trains.each { |train| yield train }
  end

  def take_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end

  def to_s
    @name
  end
end
