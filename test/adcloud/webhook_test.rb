require 'test_helper'

describe Adcloud::Webhook do
  let(:event_payload) { '{"id":"2","country_id":"1","guidance_price_cpc":"1.49","guidance_price_cpm":"0.6","variance":"20.00","modified":"2012-09-04 14:21:20","created":"2012-04-10 20:40:24","_meta":{"is_test_data":true,"model":"TopicPrice","event":"TopicDiscount.update","updated_fields":["guidance_price_cpc","guidance_price_cpm"],"id":"2"}}' }
  let(:payload) { "[#{event_payload}]" }

  subject { Adcloud::Webhook.new(payload) }

  describe '.new' do
    it 'takes an array as argument' do
      Adcloud::Webhook.new([]).events.must_equal []
    end

    it 'takes a json string as argument' do
      Adcloud::Webhook.new('[]').events.must_equal []
    end

    it 'fails with an argument error' do
      -> { Adcloud::Webhook.new('').events }.must_raise ArgumentError
    end

    it 'fails without an argument' do
      -> { Adcloud::Webhook.new().events }.must_raise ArgumentError
    end
  end

  describe '#events=' do
    describe 'configured to ignore test data' do
      before { Adcloud.config.webhooks.filter_tests = true }

      it 'removes test calls' do
        subject.events.length.must_equal 0
      end
    end

    describe 'configured to process test data' do
      before { Adcloud.config.webhooks.filter_tests = false }

      it 'keeps test calls' do
        subject.events.length.must_equal 1
      end
    end
  end

  describe '#process!' do
    it 'calls the configured proc' do
      the_proc = mock(:call => true)
      Adcloud.config.webhooks.expects(:on_topic_price_update).returns(the_proc)
      subject.process!
    end

    describe 'with multiple events' do
      let(:payload) { "[#{event_payload},#{event_payload}]" }

      it 'iterates over all events' do
        the_proc = stub(:call => true)
        Adcloud.config.webhooks.expects(:on_topic_price_update).twice.returns(the_proc)
        subject.process!
      end
    end
  end
end