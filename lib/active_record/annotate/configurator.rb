module ActiveRecord
  module Annotate
    class Configurator
      %w(yard).each do |setting|
        attr_accessor setting
        alias_method "#{setting}?", setting
      end

      attr_accessor :ignored_models
      def ignored_models=(models)
        if models.is_a?(Array)
          @ignored_models = models
        else
          raise "ActiveRecord::Annotate.config.ignored_models must be an Array of model classes"
        end
      end

      def initialize
        reset
      end

    private

      def reset
        @yard = false
        @ignored_models = []
      end

    end
  end
end
