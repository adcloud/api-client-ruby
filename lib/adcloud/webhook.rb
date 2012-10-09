module Adcloud
  class Webhook
    ALL = [:on_topic_price_update, :on_campaign_update]

    attr_accessor :events

    # @param events [Array<Hash>, String] Events
    def initialize(events)
      self.events = events.kind_of?(Array) ? events : JSON.parse(events.to_s)
    rescue
      raise ArgumentError.new("Invalid webhook event data!")
    end

    def events=(events)
      @events = [events].flatten.map { |event| Adcloud::WebhookEvent.new(event) }
      if Adcloud.config.webhooks.filter_tests
        @events.reject! { |event| event.test_data? }
      end
    end

    def process!
      self.events.each do |event|
        proc = case event.type
        when 'TopicDiscount.update'
          :on_topic_price_update
        when 'Booking.update'
          :on_campaign_update
        else
          :on_unknown_webhook
        end
        Adcloud.config.webhooks.send(proc).call(event)
      end
    end
  end
end