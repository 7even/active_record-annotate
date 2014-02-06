require 'spec_helper'

describe ActiveRecord::Annotate::Configurator do
  describe "#initialize" do
    it "resets all settings to their default values" do
      expect(subject.yard).to be_false
    end
  end
  
  describe "attr_accessors" do
    it "read and write settings' values" do
      expect(subject.yard).to be_false
      
      subject.yard = true
      expect(subject.yard).to be_true
    end
  end
end
