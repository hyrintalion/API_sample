# frozen_string_literal: true

class ApplicationInteractor
  class << self
    attr_reader :input_schema

    def schema(input_schema)
      @input_schema = input_schema
    end
  end

  def validate(input)
    input = input.to_hash.deep_symbolize_keys! if input.is_a?(Hash)

    result = schema.call(input)
    return Success(result.to_h) if result.success?

    field = result.errors.keys.first
    Failure(::Errors::FieldFormatError.new(field, result.errors[field].first).to_h)
  end

  private

  def schema
    self.class.input_schema
  end
end
