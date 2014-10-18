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
  
  it "should return a mustache-escaped string with html escaping disabled if the method calls include .html_safe" do
    obj = SnidelyWhiplash.new
    obj.example.html_safe.to_s.should eql '{{{example}}}'
    obj.nested.example.html_safe.to_s.should eql '{{{nested.example}}}'
  end
  
  it "should allow the caller to specify a parent path" do
    obj = SnidelyWhiplash.new 'parent'
    obj.example.to_s.should eql '{{parent.example}}'
    obj.nested.example.to_s.should eql '{{parent.nested.example}}'
  end
  
  # This particular example comes from a problem I ran into with haml
  it "should not try to convert to an array" do
    obj = SnidelyWhiplash.new
    ary = [obj]
    ary.flatten.should eql [obj]
  end
  
  it "should use a specific value if one is passed in" do
    obj = SnidelyWhiplash.new nil, true, 'test' => 42
    obj.test.should eql 42
  end
  
  it "should understand nesting when determining if there is a specific value to use" do
    obj = SnidelyWhiplash.new nil, true, 'nested.test' => 42
    obj.nested.test.should eql 42
  end
end