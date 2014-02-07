module ActiveRecord
  module Annotate
    class File
      attr_reader :path, :lines
      
      def initialize(path)
        @path    = path
        @content = ::File.read(path)
        @lines   = @content.split(?\n)
      end
      
      def annotate_with(annotation, configurator)
        if @lines.first =~ /^\s*#.*coding/
          # encoding: utf-8 encountered on the first line
          encoding_line = @lines.shift
        end
        
        while @lines.first.start_with?('#') || @lines.first.blank?
          # throw out comments and empty lines
          # in the beginning of the file (old annotation)
          @lines.shift
        end
        
        if configurator.yard?
          backticks = '# ```'
          annotation.unshift(backticks).push(backticks)
        end
        
        @lines.unshift(*annotation, nil)
        @lines.unshift(encoding_line) unless encoding_line.nil?
        @lines.push(nil) # newline at the end of file
      end
      
      def write
        new_file_content = @lines.join(?\n)
        temp_path = "#{@path}.annotated"
        
        ::File.open(temp_path, 'w') do |temp_file|
          temp_file.write(new_file_content)
        end
        
        ::File.delete(@path)
        ::File.rename(temp_path, @path)
      end
      
      def changed?
        @lines.join(?\n) != @content
      end
      
      def relative_path
        path.sub(/^#{Rails.root}\//, '')
      end
    end
  end
end
