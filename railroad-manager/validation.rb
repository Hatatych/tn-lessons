module Validation

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :settings
    def validate(name, validation_type, option = nil)
      @settings ||= []
      raise 'Такой проверки нет!' unless %i[presence format type].include? validation_type

      @settings << { param: name, validation_type: validation_type, option: option }
    end
  end

  module InstanceMethods
    def validate!
      self.class.settings.each do |setting|
        param_value = instance_variable_get("@#{setting[:param]}".to_sym)
        case setting[:validation_type]
        when :presence then raise 'Объект пуст!' if param_value.nil? || param_value == ''
        when :format then raise 'Формат неверный!' unless setting[:option].match? param_value
        when :type then raise 'Несовпадение типов!' if param_value.class != setting[:option]
        end
      end
    end

    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end
  end
end
