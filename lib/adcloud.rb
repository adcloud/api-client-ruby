require 'faraday'
require 'faraday_middleware'
require 'adcloud/response_error_handler'
require 'logger'
require 'active_support/configurable'
require 'virtus'

module Adcloud

  include ActiveSupport::Configurable

  autoload :Ad, "adcloud/ad"
  autoload :Advertisement, "adcloud/advertisement"
  autoload :ApiError, "adcloud/api_error"
  autoload :Attachment, "adcloud/attachment"
  autoload :Authentication, "adcloud/authentication"
  autoload :Campaign, "adcloud/campaign"
  autoload :Connection, "adcloud/connection"
  autoload :Customer, "adcloud/customer"
  autoload :Entity, "adcloud/entity"
  autoload :ExceptionRaiser, "adcloud/exception_raiser"
  autoload :Product, "adcloud/product"
  autoload :Report, "adcloud/report"

  module AdcloudSucks; class InvalidApiResponse < StandardError; end; end
  class BadRequestError < ApiError; end
  class NotFoundError < ApiError; end
  class ServerError < ApiError; end

  class << self
    # Access the logger instance
    def logger
      @@logger ||= Adcloud.config.logger || Logger.new(STDOUT)
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
  c.http_open_timeout = 5
  c.http_read_timeout = 10
  c.debug = false
end