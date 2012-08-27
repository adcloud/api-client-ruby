# encoding: utf-8
require 'test_helper'

describe Adcloud::Entity do

  class Car < Adcloud::Entity
    self.api_endpoint = 'cars'
    attribute :id, Integer
    attribute :name, String
  end

  subject { Car }

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

  describe '.api_endpoint' do
    it 'its api endpoint is cars' do
      subject.api_endpoint.must_equal 'cars'
    end
  end

  describe "find" do
    let(:response_data) { { 'id' => 42, 'name' => 'Porsche' } }

    it "should return a car" do
      subject.connection.expects(:get).with('cars/42').returns(response_data)
      subject.find(42).must_be_instance_of(Car)
    end
  end

  describe "all" do
    let(:empty_response_data) { {"_meta"=>{"type"=>"Array<>", "page"=>1, "size"=>0, "per_page"=>50, "total_count"=>0, "total_pages"=>0, "sort"=>{}, "uuid"=>"aabe4f5f31691f049ea1942e6a6d1793"}, "items"=>[]} }
    let(:response_data) { { "_meta" => { "type" => "Array<Car>", "page" => 1, "size" => 2, "per_page" => 50, "total_count" => 2, "total_pages" => 1, "sort" => {}, "uuid" => "aabe4f5f31691f049ea1942e6a6d1793" }, "items" => [{ "id" => 52654, "name" => 'Mercedes', "_meta" => { "type" => "Car" } }, { "id" => 52655, "name" => 'Audi', "_meta" => { "type" => "Car" } }]} }

    it "should return an empty array if response is empty" do
      subject.connection.expects(:get).with('cars', :filter => {}, :page => 1, :per_page => 50).returns(empty_response_data)
      subject.all.must_be_instance_of(Array)
    end

    it 'should return an array if response contains objects' do
      subject.connection.expects(:get).with('cars', :filter => {}, :page => 1, :per_page => 50).returns(response_data)
      subject.all.must_be_instance_of(Array)
    end

    it 'should return an array of cars' do
      subject.connection.expects(:get).with('cars', :filter => {}, :page => 1, :per_page => 50).returns(response_data)
      subject.all.each { |item| item.must_be_instance_of(subject) }
    end

    it 'should return 2 cars' do
      subject.connection.expects(:get).with('cars', :filter => {}, :page => 1, :per_page => 50).returns(response_data)
      subject.all.size.must_equal 2
    end

    it 'should pass the filter param' do
      subject.connection.expects(:get).with('cars', :filter => { :oliver => "ist chef" }, :page => 1, :per_page => 50).returns(response_data)
      subject.all(:oliver => "ist chef")
    end
  end

  describe '#create' do
    before { subject.stubs(:connection => connection) }

    describe 'when submitting a valid object' do
      let(:response) { { '_meta' => { 'status' => 200 }, 'id' => 1 } }

      it 'sends a request to the api' do
        car = subject.new
        attributes = car.attributes
        attributes.delete(:id)
        attributes.delete(:_meta)
        connection.expects(:post).with('cars', { 'car' => attributes }).returns(response)
        car.create
      end

      it 'sets the car id' do
        connection.stubs(:post).returns(response)
        car = subject.new
        car.create
        car.id.must_equal 1
      end

      it 'returns true' do
        connection.stubs(:post).returns(response)
        subject.new.create.must_equal true
      end
    end

    describe 'when submitting an invalid car' do
      let(:error) { Adcloud::BadRequestError.new(stub(:body => {'_meta' => { 'details' => { :name => ['cannot be empty'] }}})) }
      before do
        subject.stubs(:connection => connection)
        connection.stubs(:post).raises(error)
      end

      it 'returns false' do
        subject.new.create.must_equal false
      end

      it 'sets the errors hash' do
        car = subject.new
        car.create
        car.errors.must_equal({ :name => ['cannot be empty'] })
      end
    end
  end

  describe '.create' do
    it 'creates a new car' do
      car = subject.new
      subject.expects(:new).returns(car)
      car.expects(:create)
      subject.create.must_equal car
    end
  end

  describe "errors" do
    it "should be empty" do
      subject.new.errors.must_be_empty
    end
  end

end