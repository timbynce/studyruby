# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end
end

module ClassMethods
  attr_reader :validations

  private

  def validate(name, validation_type, option = nil)
    @validations ||= {
      presence: [],
      format: {},
      type: {}
    }

    case validation_type
    when :presence
      @validations[:presence] << name
    when :format
      @validations[:format][name] = option
    when :type
      @validations[:type][name] = option
    end
  end
end

module InstanceMethods
  def validate!
    self.class.validations.each do |validation_type, args|
      send("validate_#{validation_type}", args)
    end
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate_presence(args)
    args.each do |attribute|
      value = instance_variable_get("@#{attribute}")
      raise "Attribute #{attribute} is nil" if value.nil? || value == '' # value.present?
    end
  end

  def validate_format(args)
    args.each do |attribute, format|
      value = instance_variable_get("@#{attribute}")
      raise "Attribute #{attribute} has wrong format" if value !~ format
    end
  end

  def validate_type(args)
    args.each do |attribute, type|
      value = instance_variable_get("@#{attribute}")
      raise "Attribute #{attribute} has wrong type" unless value.is_a?(type)
    end
  end
end
