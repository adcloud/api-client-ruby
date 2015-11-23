require 'test_helper'

class DummyConnection
  def get(endpoint, params)
    {'_meta' => {'total_pages' => 3}, 'items' => [params[:page]]}
  end
end

class Foo
  include Adcloud::EndlessPages
  include Virtus
  attribute :_meta, Hash
  attribute :items, Array

  def self.endpoint_url
    ""
  end
end

describe Adcloud::EndlessPages do
  subject { 
    Foo
  }
  it "raises an ApiError after 5 retries" do
    stub_request(:post, "https://api.adcloud.com/v2/oauth/access_token").
      with(:body => {"client_id"=>true, "client_secret"=>true, "grant_type"=>"none"},
           :headers => {'Accept'=>'*/*', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Faraday v0.8.7'}).
      to_return(:status => 200, :body => "", :headers => {})
    proc {
      subject.endless_pages({})
    }.must_raise StandardError
  end

  it "iterates through all pages" do
    result = subject.endless_pages({endpoint_url: "http://www.example.com", connection: DummyConnection.new})
    result.must_equal [1,2,3]
  end

  it "gathers all results and returns a single collection" do
    result = subject.endless_pages({endpoint_url: "http://www.example.com", connection: DummyConnection.new})
    result.must_equal [1,2,3]
  end
end