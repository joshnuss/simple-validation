class ValidationBuilder
    def self.validation_method(method, old)
      define_method(method.to_s) do |*options|
        @model.send old, *options
      end
    end

    validation_method :required,  :validates_presence_of
    validation_method :unique,    :validates_uniqueness_of
    validation_method :format,    :validates_format_of
    validation_method :numeric,   :validates_numericality_of
    validation_method :length,    :validates_length_of
    validation_method :size,      :validates_length_of
    validation_method :accepts,   :validates_acceptance_of
    validation_method :confirm,   :validates_confirmation_of
    validation_method :excludes,  :validates_exclusion_of
    validation_method :includes,  :validates_includes_of
    validation_method :associate, :validates_associated_of

    def initialize(model, &block)
      @model = model
      instance_eval &block
    end
end

module SimpleValidation
  protected 
    def validation(&block)
      ValidationBuilder.new(self, &block)
    end
end
