class CargoTrain < Train
  def initialize(name)
    super
    @type = :cargo
  end

  def attachable_carriage?(carriage)
    carriage.instance_of?(CargoCarriage)
  end
end
