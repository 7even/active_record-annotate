require 'spec_helper'

describe ActiveRecord::Annotate::File do
  let(:file_path) do
    file = Tempfile.new('test_annotation')
    File.open(file.path, 'w') do |tempfile|
      tempfile.write(<<-FILE)
# enCoding: utf-8
# create_table :users do |t|
#   t.string :name
#   t.integer :age
# end

class User < ActiveRecord::Base
  has_many :posts
end
      FILE
    end
    
    file.path
  end
  
  let(:old_annotation) do
    [
      '# create_table :users do |t|',
      '#   t.string :name',
      '#   t.integer :age',
      '# end'
    ]
  end
  
  let(:new_annotation) do
    [
      '# create_table :users do |t|',
      '#   t.string :name',
      '#   t.integer :age, null: false, default: 0',
      '# end'
    ]
  end
  
  let(:expected_result) do
    <<-FILE
# enCoding: utf-8
# create_table :users do |t|
#   t.string :name
#   t.integer :age, null: false, default: 0
# end

class User < ActiveRecord::Base
  has_many :posts
end
    FILE
  end
  
  let(:expected_result_for_yard) do
    <<-FILE
# enCoding: utf-8
# ```
# create_table :users do |t|
#   t.string :name
#   t.integer :age, null: false, default: 0
# end
# ```

class User < ActiveRecord::Base
  has_many :posts
end
    FILE
  end
  
  let(:file) { ActiveRecord::Annotate::File.new(file_path) }
  let(:configurator) { ActiveRecord::Annotate::Configurator.new }
  
  describe "#annotate_with" do
    it "changes the lines adding the new annotation" do
      file.annotate_with(new_annotation, configurator)
      
      processed_file_content = file.lines.join(?\n)
      expect(processed_file_content).to eq(expected_result)
    end
    
    context "when yard setting is on" do
      let(:configurator) do
        ActiveRecord::Annotate::Configurator.new.tap do |configurator|
          configurator.yard = true
        end
      end
      
      it "adds triple backticks around the annotation" do
        file.annotate_with(new_annotation, configurator)
        
        processed_file_content = file.lines.join(?\n)
        expect(processed_file_content).to eq(expected_result_for_yard)
      end
    end
  end
  
  describe "#changed?" do
    context "with an old annotation" do
      before(:each) do
        file.annotate_with(old_annotation, configurator)
      end
      
      it "returns false" do
        expect(file).not_to be_changed
      end
    end
    
    context "with a new annotation" do
      before(:each) do
        file.annotate_with(new_annotation, configurator)
      end
      
      it "returns true" do
        expect(file).to be_changed
      end
    end
  end
  
  describe "#write" do
    before(:each) do
      file.annotate_with(new_annotation, configurator)
    end
    
    it "writes the new contents to file" do
      file.write
      
      new_file_contents = ::File.read(file.path)
      expect(new_file_contents).to eq(expected_result)
    end
  end
  
  describe "#relative_path" do
    before(:each) do
      allow(Rails).to receive(:root).and_return('root')
      allow(file).to receive(:path).and_return('root/namespace/path.rb')
    end
    
    it "returns a relative path" do
      expect(file.relative_path).to eq('namespace/path.rb')
    end
  end
end
