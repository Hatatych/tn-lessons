class CargoCarriage < Carriage
  attr_reader :free_volume, :occupied_volume

  def initialize(volume)
    @type = :cargo
    super
  end
end
