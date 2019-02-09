class PassengerTrain < Train
  # Насчет этого решения я не уверен!
  initialize_counter # инициализация начального значения счетчика экземпляров
  
  def initialize(name)
    super
    @type = :passenger
  end

  def attachable_carriage?(carriage)
    carriage.instance_of?(PassengerCarriage)
  end
end
