module ActiveRecord
  module Annotate
    module Writer
      class << self
        def write(annotation, path)
          new_file_content = assemble(annotation, path)
          
          temp_path = "#{path}.annotated"
          File.open(temp_path, 'w') do |temp_file|
            temp_file.puts(new_file_content)
          end
          
          File.delete(path)
          File.rename(temp_path, path)
        end
        
        def assemble(annotation, path)
          lines = File.read(path).split("\n")
          
          if lines.first =~ /^\s*#.*coding/
            # encoding: utf-8 encountered on the first line
            encoding_line = lines.shift
          end
          
          while lines.first.starts_with?('#') || lines.first.blank?
            # throw out comments and empty lines in the beginning of the file (old annotation)
            lines.shift
          end
          
          lines.unshift(*annotation, nil)
          lines.unshift(encoding_line) unless encoding_line.nil?
          
          lines.join("\n")
        end
      end
    end
  end
end
