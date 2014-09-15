require 'spec_helper'

describe ActiveRecord::Annotate do
  describe ".short_path_for" do
    before(:each) do
      allow(subject).to receive(:models_dir).and_return('dir')
    end
    
    it "removes the root/app/models prefix and .rb suffix" do
      short_path = subject.short_path_for('dir/namespace/model_name.rb')
      expect(short_path).to eq('namespace/model_name')
    end
  end
  
  describe ".class_name_for" do
    it "finds the class by the short path" do
      class_name = subject.class_name_for('active_record/annotate/file')
      expect(class_name).to eq(ActiveRecord::Annotate::File)
    end
  end
end
