require 'spec_helper'

describe ActiveRecord::Annotate::Configurator do
  describe "#initialize" do
    it "resets all settings to their default values" do
      expect(subject.yard).to be_falsy
      expect(subject.debug).to be_falsy
    end
  end
  
  describe "attr_accessors" do
    it "read and write settings' values" do
      expect(subject.yard).to be_falsy
      
      subject.yard = true
      expect(subject.yard).to be_truthy

      expect(subject.debug).to be_falsy
      
      subject.debug = true
      expect(subject.debug).to be_truthy
    end
  end
end
