module ActiveRecord
  module Annotate
    class Configurator
      %w(yard).each do |setting|
        attr_accessor setting
        alias_method "#{setting}?", setting
      end
      
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
