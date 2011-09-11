require 'spec_helper'

describe Tag do

  it "should create a valid Tag" do
    Tag.new(:id => 0, :name => "Test").should be_valid
   end
end