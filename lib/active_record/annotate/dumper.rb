module ActiveRecord
  module Annotate
    module Dumper
      class << self
        def dump(table_name, connection = ActiveRecord::Base.connection)
          string_io = StringIO.new
          dumper(connection).send(:table, table_name, string_io)
          
          process_annotation(string_io)
        end
        
      private
        def dumper(connection)
          ActiveRecord::SchemaDumper.send(:new, connection)
        end
        
        def process_annotation(string_io)
          string_io.string.split(?\n).map do |line|
            line.tap do |line|
              # commenting out the line
              line[0] = '#'
              # replacing strings with symbols
              line.gsub!(/"(\w+)"/, ':\1')
            end
          end
        end
      end
    end
  end
end
