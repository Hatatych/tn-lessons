class Carriage
  include Manufacturer
  attr_reader :type

  def initialize
    validate!
  end

  def to_s
    "#{@type}"
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Не указан тип вагона!" if @type.nil?
  end
end
