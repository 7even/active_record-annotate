module ActiveRecord
  module Annotate
    module Writer
      class << self
        def write(annotation, path)
          file_contents = prepare_file_at(path)
          
          temp_path = "#{path}.annotated"
          File.open(temp_path, 'w') do |temp_file|
            temp_file.write(annotation)
            temp_file.write(file_contents)
          end
          
          File.delete(path)
          File.rename(temp_path, path)
        end
        
        def prepare_file_at(path)
          lines = File.readlines(path)
          
          while lines.first.starts_with?('#') || lines.first.blank?
            # throw out comments and empty lines in the beginning of the file (old annotation)
            lines.shift
          end
          
          lines.join
        end
      end
    end
  end
end
