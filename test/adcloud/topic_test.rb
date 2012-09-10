require 'test_helper'

describe Adcloud::Topic do
  # the basic features are tested in entity test

  describe '#name=' do
    let(:raw_data) { [{ 'locale' => "es_es", 'field' => "name", 'content' => "Entretenimiento" }] }

    it 'transforms the raw json data array/hash to a more common format' do
      topic = Adcloud::Topic.new
      topic.names = raw_data
      topic.names.must_equal({ 'es_es' => 'Entretenimiento' })
    end
  end

  describe '#discounts' do
    let(:raw_data) { [{ 'country_id' => 11, 'discount' => '0.0', 'reach' => '4.0', 'min_price_cpc' => 0, 'price_cpc' => 0, 'max_price_cpc' => 0, 'min_price_cpm' => 0, 'price_cpm' => 0, 'max_price_cpm' => 0, 'country_code' => 'es' }] }
    it 'transforms the data into a hash with locale as key' do
      topic = Adcloud::Topic.new
      topic.discounts = raw_data
      topic.discounts['es'].must_be_instance_of Adcloud::TopicDiscount
    end
  end
end