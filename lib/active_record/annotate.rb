require 'active_record/annotate/dumper'
require 'active_record/annotate/writer'
require 'active_record/annotate/file'
require 'active_record/annotate/version'
require 'active_record/annotate/railtie'

module ActiveRecord
  module Annotate
    class << self
      def annotate
        puts 'Processed model files:'
        models.each do |table_name, file_paths|
          annotation = Dumper.dump(table_name)
          
          file_paths.each do |path|
            Writer.write(annotation, path)
          end
        end
      end
      
      def models
        models_dir = Rails.root.join('app/models')
        files_mask = models_dir.join('**', '*.rb')
        
        hash_with_arrays = Hash.new do |hash, key|
          hash[key] = []
        end
        
        Dir.glob(files_mask).each_with_object(hash_with_arrays) do |path, models|
          # .../app/models/car/hatchback.rb -> car/hatchback
          short_path = path.sub(models_dir.to_s + '/', '').sub(/\.rb$/, '')
          # skip any app/models/concerns files
          next if short_path.starts_with?('concerns')
          
          # car/hatchback -> Car::Hatchback
          klass = short_path.camelize.constantize
          # collect only AR::Base descendants
          models[klass.table_name] << path if klass < ActiveRecord::Base
        end
      end
    end
  end
end
