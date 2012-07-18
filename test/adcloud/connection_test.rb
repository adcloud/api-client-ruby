require 'test_helper'

describe Adcloud::Connection do

  describe "connection" do

    before do
      @conn = Adcloud::Connection.new
    end

    describe "not logged connection" do

      it "should open a connection to https://api.adcloud.net:80/" do
        @conn.connection.url_prefix.to_s.must_equal "https://api.adcloud.net:80/"
      end

      it "shouldn't have a handler" do
        @conn.connection.builder.handlers.must_include(Faraday::Response::Logger)
      end

    end

  end

end