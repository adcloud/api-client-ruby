require 'faraday'
require 'faraday_middleware'
require 'adcloud/response_error_handler'

require 'logger'

require 'active_support/configurable'
require 'virtus'

module Adcloud
  
  include ActiveSupport::Configurable

  autoload :Ad, "adcloud/ad"
  autoload :Attachment, "adcloud/attachment"
  autoload :Campaign, "adcloud/campaign"
  autoload :Authentication, "adcloud/authentication"
  autoload :Report, "adcloud/report"  
  autoload :Connection, "adcloud/connection"
  autoload :Entity, "adcloud/entity"

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
  c.port = 80
  c.protocol = 'https'
  c.host = 'api.adcloud.net'
  c.api_version = "v2"
  c.http_open_timeout = 5
  c.http_read_timeout = 10
  c.debug = false
end