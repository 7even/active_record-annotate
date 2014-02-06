module ActiveRecord
  module Annotate
    class Configurator
      attr_accessor :yard
      
      def initialize
        reset
      end
      
    private
      def reset
        @yard = false
      end
    end
  end
end
