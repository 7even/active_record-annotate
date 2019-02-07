module ActiveRecord
  module Annotate
    class Configurator
      BOOLEAN_ATTRIBUTES = %w(yard debug)

      BOOLEAN_ATTRIBUTES.each do |setting|
        attr_accessor setting
        alias_method "#{setting}?", setting
      end

      def initialize
        reset
      end

    private
      def reset
        BOOLEAN_ATTRIBUTES.each do |attr|
          instance_variable_set("@#{attr}", false)
        end
      end
    end
  end
end
