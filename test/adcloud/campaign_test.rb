# -*- encoding : utf-8 -*-
require 'test_helper'

describe Adcloud::Campaign do
  subject { Adcloud::Campaign }

  let(:campaign) { subject.new }
  let(:connection) { stub() }

  before do
    subject.stubs(:connection => connection)
  end

  describe "validate" do
    it 'should validate against the api' do
      connection.expects(:get).with('campaigns/validate', campaign.attributes).returns({'_meta' => { 'status' => 226, 'details' => {}}})
      campaign.validate
    end

    it 'should populate the errors hash' do
      response_data = {'_meta' => { 'status' => 226, 'details' => { 'company_id' => ['must be present'] } } }
      connection.expects(:get).with('campaigns/validate', campaign.attributes).returns(response_data)
      campaign.validate
      campaign.errors['company_id'].must_equal ['must be present']
    end

    it 'raises an exception when the response is not well formatted' do
      connection.expects(:get).with('campaigns/validate', campaign.attributes)
      -> { campaign.validate }.must_raise(Adcloud::AdcloudUnknownAPIError::InvalidApiResponse)
    end
  end

  describe '#valid?' do
    it 'validates the model' do
      campaign.expects(:validate)
      campaign.valid?
    end

    it 'returns true when object is valid' do
      campaign.stubs(:validate)
      campaign.errors = {}
      campaign.valid?.must_equal true
    end

    it 'returns false when the object is invalid' do
      campaign.stubs(:validate)
      campaign.errors = { company_id: ['must be present'] }
      campaign.valid?.must_equal false
    end
  end

end