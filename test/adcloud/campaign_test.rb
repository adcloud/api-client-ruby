require 'test_helper'

describe Adcloud::Campaign do

  describe "errors" do
    it "should return an existing errors object"
    it "should return an new errors object"
  end

  describe "all" do
    it "should return an array contains campaign objects"
    it "should return an empty array if no campaign objects given"
    it "should raise an InvalidFilter Exception"
    it "should raise an InvalidRequest Exception"
  end

  describe "find" do
    it "should return an campaign object"
    it "should raise a NotFound Exception"
    it "should raise an InvalidRequest Exception"
  end
end