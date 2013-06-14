require 'spec_helper'
require 'snidely_whiplash'

describe SnidelyWhiplash do
  it "should respond to a method with a new instance of itself" do
    obj = SnidelyWhiplash.new
    obj.example.should be_an_instance_of SnidelyWhiplash
    obj.nested.example.should be_an_instance_of SnidelyWhiplash
  end
  
  it "should return a mustache-escaped string describing the method calls" do
    obj = SnidelyWhiplash.new
    obj.example.to_s.should eql '{{example}}'
    obj.nested.example.to_s.should eql '{{nested.example}}'
  end
  
  it "should allow the caller to specify a parent path" do
    obj = SnidelyWhiplash.new 'parent'
    obj.example.to_s.should eql '{{parent.example}}'
    obj.nested.example.to_s.should eql '{{parent.nested.example}}'
  end
end