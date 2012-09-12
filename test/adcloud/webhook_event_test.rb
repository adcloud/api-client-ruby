require 'test_helper'

describe Adcloud::WebhookEvent do
  let(:payload) { { 'id' => 1, 'name' => 'Test run', '_meta' => { 'event' => 'Test.create', 'foo' => 'bar' } } }

  subject { Adcloud::WebhookEvent.new(payload) }

  describe '#type' do
    specify { subject.type.must_equal 'Test.create' }
  end

  describe '#data' do
    specify { subject.data.must_equal({ 'id' => 1, 'name' => 'Test run' }) }
  end

  describe '#meta' do
    specify { subject.meta.must_equal({ 'event' => 'Test.create', 'foo' => 'bar' }) }
  end
end