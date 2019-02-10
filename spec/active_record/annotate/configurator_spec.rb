require 'spec_helper'

describe ActiveRecord::Annotate::Configurator do
  describe "#initialize" do
    it "resets all settings to their default values" do
      expect(subject.yard).to be_falsy
      expect(subject.ignored_models).to eq([])
    end
  end
  
  describe "attr_accessors" do
    it "read and write settings' values" do
      expect(subject.yard).to be_falsy
      
      subject.yard = true
      expect(subject.yard).to be_truthy

      expect(subject.ignored_models).to eq([])
      
      subject.ignored_models = [:foobar]
      subject.ignored_models.push(:bar)
      expect(subject.ignored_models).to eq([:foobar, :bar])

      expect {
        subject.ignored_models = "bad value"
      }.to raise_exception(StandardError)
    end
  end
end
