class CargoCarriage < Carriage
  NO_VOLUME = "Недостаточно свободного объема!"
  NEGATIVE_VOLUME = "Начальный объем не может быть меньше 1!"

  attr_reader :free_volume, :occupied_volume

  def initialize(volume)
    @type = :cargo
    @free_volume = volume
    @occupied_volume = 0
    super()
    validate!
  end

  def load(volume)
    if @free_volume >= volume
      @free_volume -= volume
      @occupied_volume += 1
    else
      raise NO_VOLUME
    end
  end

  private

  def validate!
    raise NEGATIVE_VOLUME unless @free_volume > 0
  end
end
