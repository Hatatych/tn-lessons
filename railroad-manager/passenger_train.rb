require_relative './validation.rb'

class PassengerTrain < Train
  include Validation

  validate :name, :format, /^[a-z\d]{3}-?[a-z\d]{2}$/i
  validate :type, :presence

  def initialize(name)
    @type = :passenger
    super
  end

  def attachable_carriage?(carriage)
    carriage.instance_of?(PassengerCarriage)
  end
end
