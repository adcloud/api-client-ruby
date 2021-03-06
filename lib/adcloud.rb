require 'faraday'
require 'faraday_middleware'
require 'adcloud/response_error_handler'
require 'logger'
require 'active_support/configurable'
require 'active_support/inflector'
require 'virtus'

module Adcloud

  include ActiveSupport::Configurable

  autoload :Ad, "adcloud/ad"
  autoload :Advertisement, "adcloud/advertisement"
  autoload :ApiError, "adcloud/api_error"
  autoload :Authentication, "adcloud/authentication"
  autoload :Campaign, "adcloud/campaign"
  autoload :CampaignPerformanceData, "adcloud/campaign_performance_data"
  autoload :CampaignPerformanceDataEntry, "adcloud/campaign_performance_data_entry"
  autoload :Connection, "adcloud/connection"
  autoload :Customer, "adcloud/customer"
  autoload :Entity, "adcloud/entity"
  autoload :ExceptionRaiser, "adcloud/exception_raiser"
  autoload :MediaFile, "adcloud/media_file"
  autoload :EndlessPages, "adcloud/endless_pages"
  autoload :Product, "adcloud/product"
  autoload :Report, "adcloud/report"
  autoload :ReportEntry, "adcloud/report_entry"
  autoload :Topic, "adcloud/topic"
  autoload :TopicDiscount, "adcloud/topic_discount"
  autoload :Webhook, "adcloud/webhook"
  autoload :WebhookConfig, "adcloud/webhook_config"
  autoload :WebhookEvent, "adcloud/webhook_event"

  module AdcloudUnknownAPIError; class InvalidApiResponse < StandardError; end; end
  class UnknownError < ApiError; end
  class BadRequestError < ApiError; end
  class NotFoundError < ApiError; end
  class ServerError < ApiError; end
  class Unauthorized < ApiError; end

  class << self
    # Access the logger instance
    def logger
      @@logger ||= (defined?(Rails) && Rails.logger) || Adcloud.config.logger || Logger.new(STDOUT)
    end

    # Allow to override the logger
    def logger=(input)
      @@logger = input
    end
  end

end

Adcloud.configure do |c|
  c.port = 443
  c.protocol = 'https'
  c.host = 'api.adcloud.com'
  c.api_version = "v2"
  c.http_open_timeout = 120
  c.http_read_timeout = 1800
  c.debug = false
  c.webhooks = Adcloud::WebhookConfig.new
  c.webhooks.filter_tests = true
end