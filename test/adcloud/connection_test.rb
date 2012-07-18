require 'test_helper'

describe Adcloud::Connection do

  describe "connection" do

    describe "not logged connection" do

      before do
        @conn = Adcloud::Connection.new
      end

      it "should open a connection to https://api.adcloud.net:80/" do
        @conn.connection.url_prefix.to_s.must_equal "https://api.adcloud.net:80/"
      end

      it "shouldn't have a handler" do
        @conn.connection.builder.handlers.wont_include(Faraday::Response::Logger)
      end

    end

    describe "logged connection" do
      # before do
      #   Adcloud.config.debug = true
      # end

      it "should have a logger handler" #do
      #   @adcloud_auth.connection.builder.handlers.must_include(Faraday::Response::Logger)
      # end

    end

  end

end