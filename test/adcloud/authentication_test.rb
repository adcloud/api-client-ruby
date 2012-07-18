require 'test_helper'

describe Adcloud::Authentication do

  describe "initialization" do

    describe "with a valid hash" do
      before do
        @adcloud_auth = Adcloud::Authentication.new(:client_id => "0987654321", :client_secret => "1234567890")
      end

      it "should have a client_id 0987654321" do
        @adcloud_auth.client_id.must_equal "0987654321"
      end

      it "should have a client_secret 1234567890" do
        @adcloud_auth.client_secret.must_equal "1234567890"
      end

    end

    describe "with an empty hash" do

      before do
        @adcloud_auth = Adcloud::Authentication.new({})
      end

      it "should have a client_id and client_secret being nil" do
        @adcloud_auth.client_secret.must_be_nil
        @adcloud_auth.client_id.must_be_nil       
      end      

    end

  end

  describe "is successful" do
    
    it "should return a token" do
      stub_request(:post, "https://api.adcloud.net:80/v2/oauth/access_token").with(:body => {"client_id"=>"0987654321", "client_secret"=>"1234567890", "grant_type"=>"none"}, :headers => {'Accept'=>'*/*', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Ruby'}).to_return(:status => 200, :body => "{\"access_token\":\"bab0e5c477f211c4612345678907498b6e55600\",\"scope\":\"\"}", :headers => {})
      adcloud_auth = Adcloud::Authentication.new(:client_id => "0987654321", :client_secret => "1234567890")
      adcloud_auth.authenticate!
      adcloud_auth.token.must_equal "bab0e5c477f211c4612345678907498b6e55600"
    end

  end

  describe "is unsuccessful" do
    
    it "should raise an authentication error" #do
    #   stub_request(:post, "https://api.adcloud.net:80/v2/oauth/access_token").with(:body => {"client_id"=>"0987654321", "client_secret"=>"1234567890", "grant_type"=>"none"}, :headers => {'Accept'=>'*/*', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Ruby'}).to_return(:status => 401, :body => "{\"status\":401,\"errors\":[{\"message\":\"Bad credentials\"}]}", :headers => {})
    #   adcloud_auth = Adcloud::Authentication.new(:client_id => "0987654321", :client_secret => "1234567890")        
    #   expect { adcloud_auth.authenticate! }.to raise_error(Adcloud::AuthenticationError)
    # end

  end

end