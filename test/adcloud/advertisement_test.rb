# -*- encoding : utf-8 -*-
require 'test_helper'

describe Adcloud::Advertisement do

  subject { Adcloud::Advertisement }

  let(:connection) { stub() }

  before do
    subject.stubs(:connection => connection)
  end

  describe "errors" do

    it "should be empty" do
      subject.new.errors.must_be_empty
    end

  end
  
end
