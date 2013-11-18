module ActiveRecord
  module Annotate
    module Writer
      class << self
        def write(annotation, path)
          original_file_content = File.read(path)
          lines = original_file_content.split("\n")
          
          processed_lines = process(lines, annotation)
          new_file_content = processed_lines.join("\n")
          
          if new_file_content != original_file_content
            temp_path = "#{path}.annotated"
            File.open(temp_path, 'w') do |temp_file|
              temp_file.write(new_file_content)
            end
            
            File.delete(path)
            File.rename(temp_path, path)
            
            relative_path = path.sub(/^#{Rails.root}\//, '')
            puts "* #{relative_path}"
          end
        end
        
        def process(lines, annotation)
          if lines.first =~ /^\s*#.*coding/
            # encoding: utf-8 encountered on the first line
            encoding_line = lines.shift
          end
          
          while lines.first.starts_with?('#') || lines.first.blank?
            # throw out comments and empty lines in the beginning of the file (old annotation)
            lines.shift
          end
          
          lines.tap do |lines|
            lines.unshift(*annotation, nil)
            lines.unshift(encoding_line) unless encoding_line.nil?
            lines.push(nil) # newline at the end of file
          end
        end
      end
    end
  end
end
