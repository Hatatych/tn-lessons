require_relative './manufacturer.rb'

class Carriage
  include Manufacturer
  attr_reader :type, :free_volume

  NIL_TYPE = 'Не указан тип вагона!'.freeze
  NO_VOLUME = 'Недостаточно свободного объема или мест!'.freeze
  NEGATIVE_VOLUME = 'Начальный объем/кол-во мест не может быть меньше 1!'.freeze

  def initialize(volume)
    @free_volume = volume
    @occupied_volume = 0
    validate!
  end

  def to_s
    @type.to_s
  end

  def load(volume)
    raise NEGATIVE_VOLUME if volume < 0
    raise NO_VOLUME if volume > @free_volume

    @free_volume -= volume
    @occupied_volume += volume
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise NIL_TYPE if @type.nil?
    raise NEGATIVE_VOLUME if @free_volume < 1
  end
end
