require 'spec_helper'

describe Comment do

  it "should create a valid Comment" do
    Comment.new(:comment => "Test").should be_valid
  end

  it "should not create a valid empty Comment" do
    Comment.new(:comment => "").should_not be_valid
  end

end