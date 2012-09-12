module Adcloud
  class WebhookConfig < ActiveSupport::Configurable::Configuration
    def initialize
      Adcloud::Webhook::ALL.each do |hook|
        self.send("#{hook}=", WebhookConfig.method(:unused_webhook))
      end
      self.on_unknown_webhook = WebhookConfig.method(:unknown_webhook)
    end

    def self.unused_webhook(event)
      Adcloud.logger.warn { "Webhook behaviour missing for #{event.inspect}" }
    end

    def self.unknown_webhook(event)
      Adcloud.logger.warn { "Unknown webhook event #{event.inspect}. Please contact gem maintainer!" }
    end
  end
end