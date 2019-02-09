class Carriage
  include Manufacturer
  attr_reader :type

  def to_s
    "#{@type}"
  end
end
