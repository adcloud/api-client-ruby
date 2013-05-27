require 'test_helper'

describe "Adcloud" do

  describe "Configuration" do

    subject { Adcloud.config }

    it "should return the default debug setting" do
      subject.debug.must_equal false
    end

    it "should return the default port" do
      subject.port.must_equal 443
    end

    it "should return the default protocol" do
      subject.protocol.must_equal 'https'
    end

    it "should return the default host" do
      subject.host.must_equal 'api.adcloud.com'
    end

    it "should return the default version" do
      subject.api_version.must_equal 'v2'
    end

    it "should return the default open timout" do
      subject.http_open_timeout.must_equal 120
    end

    it "should return the default read timeout" do
      subject.http_read_timeout.must_equal 1800
    end

  end

  describe "Logger" do

    it "should be a logger" do
      Adcloud.logger.must_be_instance_of Logger
    end

  end

end