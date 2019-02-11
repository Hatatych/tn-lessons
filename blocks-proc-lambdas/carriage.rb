class Carriage
  include Manufacturer
  attr_reader :type

  NIL_TYPE = "Не указан тип вагона!"

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
    raise NIL_TYPE if @type.nil?
  end
end
