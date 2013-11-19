require 'active_record/annotate/dumper'
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
            file = File.new(path)
            file.annotate_with(annotation)
            
            if file.changed?
              file.write
              puts "* #{relative_path_for(path)}"
            end
          end
        end
      end
      
      def models
        files_mask = models_dir.join('**', '*.rb')
        
        hash_with_arrays = Hash.new do |hash, key|
          hash[key] = []
        end
        
        Dir.glob(files_mask).each_with_object(hash_with_arrays) do |path, models|
          short_path = short_path_for(path)
          next if short_path.starts_with?('concerns') # skip any app/models/concerns files
          
          klass = class_name_for(short_path)
          next unless klass < ActiveRecord::Base # collect only AR::Base descendants
          
          models[klass.table_name] << path
        end
      end
      
      # .../app/models/car/hatchback.rb -> car/hatchback
      def short_path_for(full_path)
        full_path.sub(models_dir.to_s + '/', '').sub(/\.rb$/, '')
      end
      
      # car/hatchback -> Car::Hatchback
      def class_name_for(short_path)
        short_path.camelize.constantize
      end
      
      def relative_path_for(full_path)
        full_path.sub(/^#{Rails.root}\//, '')
      end
      
    private
      def models_dir
        Rails.root.join('app/models')
      end
    end
  end
end
