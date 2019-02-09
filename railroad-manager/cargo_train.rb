class CargoTrain < Train
  # Насчет этого решения я не уверен!
  initialize_counter # инициализация начального значения счетчика экземпляров
  
  def initialize(name)
    super
    @type = :cargo
  end

  def attachable_carriage?(carriage)
    carriage.instance_of?(CargoCarriage)
  end
end
