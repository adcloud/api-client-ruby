# -*- encoding : utf-8 -*-
require 'test_helper'

describe Adcloud::Campaign do
  subject { Adcloud::Campaign }

  let(:connection) { stub() }

  before do
    subject.stubs(:connection => connection)
  end

  describe "errors" do

    it "should be empty" do
      subject.new.errors.must_be_empty
    end

  end

  describe '#initialize' do
    let(:response_data) { {"id"=>123, "bidding_enabled"=>0, "name"=>"Tagesgeld / August 08", "customer_id"=>0, "company_id"=>1, "company_name"=>"Adcloud GmbH", "product_id"=>2564, "product_name"=>"Volkswagen Bank Tagesgeld", "status"=>10, "language_id"=>1, "start_date"=>"2008-08-15", "end_date"=>"2008-09-16", "delivery_boost"=>1.0, "frequency_capping"=>0, "frequency_capping_days"=>0, "cookie_lifetime"=>30, "cookie_lifetime_view"=>4, "fallback"=>false, "keywords"=>nil, "exclusion_keywords"=>nil, "keyword_lifetime"=>0, "comment"=>nil, "bookkeeping_reference"=>nil, "budget_limit"=>5510.5, "unit_price_maximum"=>1.07, "locations"=>nil, "type"=>2, "delivery_external"=>1, "delivery_internal"=>1, "delivery_type"=>0, "deactivated_on"=>nil, "modified"=>"2012-06-14T07:47:15Z", "created"=>"2008-08-13T13:18:12Z", "_meta"=>{"type"=>"Campaign"}} }
    let(:campaign_data) { {"id"=>123, "bidding_enabled"=>false, "name"=>"Tagesgeld / August 08", "customer_id"=>0, "company_id"=>1, "company_name"=>"Adcloud GmbH", "product_id"=>2564, "product_name"=>"Volkswagen Bank Tagesgeld", "status"=>10, "language_id"=>1, "start_date"=>Date.new(2008,8,15), "end_date"=>Date.new(2008,9,16), "delivery_boost"=>1.0, "frequency_capping"=>0, "frequency_capping_days"=>0, "cookie_lifetime"=>30, "cookie_lifetime_view"=>4, "fallback"=>false, "keywords"=>nil, "exclusion_keywords"=>[], "keyword_lifetime"=>0, "comment"=>nil, "budget_limit"=>5510.5, "unit_price_maximum"=>1.07, "locations"=>[], "type"=>2, "delivery_external"=>true, "delivery_internal"=>true, "delivery_type"=>0, "deactivated_on"=>nil, "modified"=>DateTime.new(2012,6,14,7,47,15), "created"=>DateTime.new(2008,8,13,13,18,12), "_meta"=>{"type"=>"Campaign"}} }

    it 'should create a campaign object from hash' do
      campaign_data.each do |key, value|
        subject.new(response_data).send(key).must_equal(value, "Key #{key}")
      end
    end

  end

  describe "all" do

    let(:empty_response_data) { {"_meta"=>{"type"=>"Array<>", "page"=>1, "size"=>0, "per_page"=>50, "total_count"=>0, "total_pages"=>0, "sort"=>{}, "uuid"=>"aabe4f5f31691f049ea1942e6a6d1793"}, "items"=>[]} }
    let(:response_data) { {"_meta"=>{"type"=>"Array<Campaign>", "page"=>1, "size"=>2, "per_page"=>50, "total_count"=>845, "total_pages"=>17, "sort"=>{}, "uuid"=>"aabe4f5f31691f049ea1942e6a6d1793"}, "items"=>[{"id"=>52654, "bidding_enabled"=>0, "name"=>"Tagesgeld / August 08", "customer_id"=>0, "company_id"=>1, "company_name"=>"Adcloud GmbH", "product_id"=>2564, "product_name"=>"Volkswagen Bank Tagesgeld", "status"=>10, "language_id"=>1, "start_date"=>"2008-08-15", "end_date"=>"2008-09-16", "delivery_boost"=>1.0, "frequency_capping"=>0, "frequency_capping_days"=>0, "cookie_lifetime"=>30, "cookie_lifetime_view"=>4, "fallback"=>false, "keywords"=>nil, "exclusion_keywords"=>nil, "keyword_lifetime"=>0, "comment"=>nil, "bookkeeping_reference"=>nil, "budget_limit"=>5510.5, "unit_price_maximum"=>1.07, "locations"=>nil, "type"=>2, "delivery_external"=>1, "delivery_internal"=>1, "delivery_type"=>0, "deactivated_on"=>nil, "modified"=>"2012-06-14T07:47:15Z", "created"=>"2008-08-13T13:18:12Z", "_meta"=>{"type"=>"Campaign"}}, {"id"=>53979, "bidding_enabled"=>0, "name"=>"Glückwunschwochen / September 08", "customer_id"=>0, "company_id"=>1, "company_name"=>"Adcloud GmbH", "product_id"=>2648, "product_name"=>"Mitsubishi Glückwunschwochen", "status"=>10, "language_id"=>1, "start_date"=>"2008-09-01", "end_date"=>"2008-09-27", "delivery_boost"=>1.0, "frequency_capping"=>0, "frequency_capping_days"=>0, "cookie_lifetime"=>30, "cookie_lifetime_view"=>4, "fallback"=>false, "keywords"=>nil, "exclusion_keywords"=>nil, "keyword_lifetime"=>0, "comment"=>nil, "bookkeeping_reference"=>nil, "budget_limit"=>4815.0, "unit_price_maximum"=>1.07, "locations"=>nil, "type"=>2, "delivery_external"=>1, "delivery_internal"=>1, "delivery_type"=>0, "deactivated_on"=>nil, "modified"=>"2012-06-14T07:47:15Z", "created"=>"2008-09-02T17:48:34Z", "_meta"=>{"type"=>"Campaign"}}]} }

    it "should return an empty array if response is empty" do
      subject.connection.expects(:get).with('campaigns', :filter => {}, :page => 1, :per_page => 50).returns(empty_response_data)
      subject.all.must_be_instance_of(Array)
    end

    it 'should return an array if response contains objects' do
      subject.connection.expects(:get).with('campaigns', :filter => {}, :page => 1, :per_page => 50).returns(response_data)
      subject.all.must_be_instance_of(Array)
    end

    it 'should return an array of campaign objects' do
      subject.connection.expects(:get).with('campaigns', :filter => {}, :page => 1, :per_page => 50).returns(response_data)
      subject.all.each { |item| item.must_be_instance_of(subject) }
    end

    it 'should return 2 campaign objects' do
      subject.connection.expects(:get).with('campaigns', :filter => {}, :page => 1, :per_page => 50).returns(response_data)
      subject.all.size.must_equal 2
    end

    it 'should pass the filter param' do
      subject.connection.expects(:get).with('campaigns', :filter => {:oliver => "ist chef"}, :page => 1, :per_page => 50).returns(response_data)
      subject.all(:oliver => "ist chef")
    end
  end

  describe "find" do
    let(:response_data) { {"id"=>123, "bidding_enabled"=>0, "name"=>"Tagesgeld / August 08", "customer_id"=>0, "company_id"=>1, "company_name"=>"Adcloud GmbH", "product_id"=>2564, "product_name"=>"Volkswagen Bank Tagesgeld", "status"=>10, "language_id"=>1, "start_date"=>"2008-08-15", "end_date"=>"2008-09-16", "delivery_boost"=>1.0, "frequency_capping"=>0, "frequency_capping_days"=>0, "cookie_lifetime"=>30, "cookie_lifetime_view"=>4, "fallback"=>false, "keywords"=>nil, "exclusion_keywords"=>nil, "keyword_lifetime"=>0, "comment"=>nil, "bookkeeping_reference"=>nil, "budget_limit"=>5510.5, "unit_price_maximum"=>1.07, "locations"=>nil, "type"=>2, "delivery_external"=>1, "delivery_internal"=>1, "delivery_type"=>0, "deactivated_on"=>nil, "modified"=>"2012-06-14T07:47:15Z", "created"=>"2008-08-13T13:18:12Z", "_meta"=>{"type"=>"Campaign"}} }

    it "should return an campaign object" do
      subject.connection.expects(:get).with('campaigns/123').returns(response_data)
      subject.find(123).must_be_instance_of(subject)
    end
  end

  describe "validate" do

    it "should validate parameters"

    it "should check if campaign is valid"

  end

  describe "create" do

    it "should create a campaign"

    it "should not create a campaign"
     
  end

end