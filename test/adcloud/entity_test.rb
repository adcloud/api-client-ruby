require 'test_helper'

describe Adcloud::Entity do

  subject { Adcloud::Entity }

  let(:connection) { stub }

  describe ".connection" do
    it "should return a connection object" do
      Adcloud::Connection.expects(:new).returns(connection)
      subject.connection.must_equal(connection)
    end
  end

  describe "#connection" do
    it "should return the class level connection object" do
      subject.expects(:connection).returns(connection)
      subject.new.connection.must_equal(connection)
    end
  end

end