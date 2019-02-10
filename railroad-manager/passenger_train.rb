class PassengerTrain < Train

  def initialize(name)
    super
    @type = :passenger
  end

  def attachable_carriage?(carriage)
    carriage.instance_of?(PassengerCarriage)
  end
end
