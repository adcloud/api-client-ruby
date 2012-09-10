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
end