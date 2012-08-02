# -*- encoding : utf-8 -*-
require 'test_helper'

describe Adcloud::Advertisement do


  describe "errors" do

    it "should be empty" do
      subject.new.errors.must_be_empty
    end

  end
  
end
