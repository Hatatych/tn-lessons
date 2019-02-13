class CargoTrain < Train

  def initialize(name)
    @type = :cargo
    super
  end

  def attachable_carriage?(carriage)
    carriage.instance_of?(CargoCarriage)
  end
end
