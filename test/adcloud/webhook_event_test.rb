require 'test_helper'

describe Adcloud::WebhookEvent do
  let(:payload) { { 'id' => 1, 'name' => 'Test run', '_meta' => { 'event' => 'Test.create', 'foo' => 'bar' } } }

  subject { Adcloud::WebhookEvent.new(payload) }

  describe '#type' do
    it 'returns the event type' do
      subject.type.must_equal 'Test.create'
    end
  end

  describe '#data' do
    it 'returns only the event data' do
      subject.data.must_equal({ 'id' => 1, 'name' => 'Test run' })
    end
  end

  describe '#meta' do
    it 'returns the event meta data' do
      subject.meta.must_equal({ 'event' => 'Test.create', 'foo' => 'bar' })
    end
  end
end