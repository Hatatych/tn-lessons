class PassengerTrain < Train
  def initialize(name)
    @type = :passenger
    super
  end

  def attachable_carriage?(carriage)
    carriage.instance_of?(PassengerCarriage)
  end
end
