module Accessors
  def self.included(base)
    base.extend ClassMethods
  end
end

module ClassMethods
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      history_name = "@#{name}_history".to_sym

      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}_history") { instance_variable_get(history_name) }

      define_method("#{name}=".to_sym) do |value|
        history = instance_variable_get(history_name)
        history ||= []
        history << value
        instance_variable_set(history_name, history)

        instance_variable_set(var_name, value)
      end
    end
  end

  def strong_attr_accessor(name, class_name)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise 'Wrong class!' unless value.class.to_s == class_name

      instance_variable_set(var_name, value)
    end
  end
end
