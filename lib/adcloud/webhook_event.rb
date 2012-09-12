module Adcloud
  class WebhookEvent
    attr_reader :data, :meta

    def initialize(raw_response)
      @meta = raw_response.delete('_meta') || {}
      @data = raw_response || {}
    end

    def type
      @meta['event']
    end

    def test_data?
      @meta.has_key?('is_test_data') && @meta['is_test_data']
    end
  end
end