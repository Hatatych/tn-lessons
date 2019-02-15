require_relative './instance_counter.rb'

class Station
  include InstanceCounter
  attr_reader :trains, :name

  self.class.all_stations = []
  NAME_FORMAT = /^[a-z]+$/i
  WRONG_FORMAT = 'Название может содержать только буквы!'.freeze

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    self.class.all_stations << self
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

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate!
    raise WRONG_FORMAT unless NAME_FORMAT.match? @name
  end
end
