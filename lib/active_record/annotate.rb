require 'active_record/annotate/dumper'
require 'active_record/annotate/version'
require 'active_record/annotate/railtie'

module ActiveRecord
  module Annotate
    class << self
      def annotate
        models.each do |table_name, file_path|
          annotation = Dumper.dump(table_name)
          write_annotation(annotation, file_path)
        end
      end
      
      def models
        models_dir = Rails.root.join('app/models')
        files_mask = models_dir.join('**', '*.rb')
        
        Dir.glob(files_mask).each_with_object(Hash.new) do |path, models|
          # .../app/models/car/hatchback.rb -> car/hatchback
          short_path = path.sub(models_dir.to_s + '/', '').sub(/\.rb$/, '')
          # skip any app/models/concerns files
          next if short_path.starts_with?('concerns')
          
          # car/hatchback -> Car::Hatchback
          klass = short_path.camelize.constantize
          # collect only AR::Base descendants
          models[klass.table_name] = path if klass < ActiveRecord::Base
        end
      end
      
      def write_annotation(annotation, path)
        file_contents = File.read(path)
        
        temp_path = "#{path}.annotated"
        File.open(temp_path, 'w') do |temp_file|
          temp_file.puts(annotation)
          temp_file.write(file_contents)
        end
        
        File.delete(path)
        File.rename(temp_path, path)
      end
    end
  end
end
