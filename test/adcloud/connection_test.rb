require 'test_helper'

describe Adcloud::Connection do

  subject { Adcloud::Connection.new }

  let(:authentication) { stub(:authenticate! => true, :token => "0987654321") }

  describe "url" do
    it "should be https://api.adcloud.com:443/" do
      subject.url.must_equal "https://api.adcloud.com:443/v2/"
    end
  end

  describe "authentication token" do
    it "should be 0987654321" do
      subject.expects(:authentication).returns(authentication)
      subject.authentication_token.must_equal "0987654321"
    end
  end

  describe "authentication" do
    it "should return an authentication object" do
      Adcloud::Authentication.expects(:new).returns(authentication)
      subject.authentication.must_equal authentication
    end
  end

  describe "an authenticated connection" do
    let(:url) { "https://api.adcloud.com:443/v2/whatever" }

    before do
      subject.stubs(:authentication_token).returns("0987654321")
    end

    describe "post" do
      it "should fire a post request" do
        stub_request(:post, url).to_return(:status => 200, :body => {"_meta" => {}, "hello" => "world"}, :headers => {})
        subject.post('whatever').must_equal({"_meta" => {}, "hello" => "world" })
      end
    end

    describe "put" do
      it "should fire a put request" do
        stub_request(:put, url).to_return(:status => 200, :body => { "_meta" => {}, "hello" => "world" }, :headers => {})
        subject.put('whatever').must_equal({ "_meta" => {}, "hello" => "world" })
      end
    end

    describe "get" do
      it "should fire a get request" do
        stub_request(:get, url).to_return(:status => 200, :body => {"_meta" => {}, "hello" => "world"}, :headers => {})
        subject.get('whatever').must_equal({"_meta" => {}, "hello" => "world" })
      end
    end
  end
end