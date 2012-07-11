require 'test_helper'

describe "AdcloudSdk" do

  describe "Configuration" do

    subject { AdcloudSdk::Configuration.config }

    it "should return the default debug setting" do
      subject.debug.must_equal true
    end   

    it "should return the default port" do
      subject.port.must_equal 80
    end   

    it "should return the default protocol" do
      subject.protocol.must_equal 'https'
    end   

    it "should return the default host" do
      subject.host.must_equal 'api.adcloud.net'
    end   

    it "should return the default open timout" do
      subject.http_open_timeout.must_equal 5
    end   

    it "should return the default read timeout" do
      subject.http_read_timeout.must_equal 10
    end   

  end

  describe "Logger" do

    it "should be a logger" do
      AdcloudSdk.logger.must_be_instance_of Logger
    end

  end

end