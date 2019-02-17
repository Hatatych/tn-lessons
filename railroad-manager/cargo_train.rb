require_relative './validation.rb'

class CargoTrain < Train
  include Validation

  validate :name, :format, /^[a-z\d]{3}-?[a-z\d]{2}$/i
  validate :type, :presence

  def initialize(name)
    @type = :cargo
    super
  end

  def attachable_carriage?(carriage)
    carriage.instance_of?(CargoCarriage)
  end
end
