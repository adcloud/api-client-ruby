require 'net/http'
require 'net/https'
require 'digest'
require 'logger'
require 'json'
require 'base64'
require 'active_support/configurable'

module Adcloud
  include ActiveSupport::Configurable

  autoload :Ad, "adcloud/ad"
  autoload :Attachment, "adcloud/attachment"
  autoload :Campaign, "adcloud/campaign"
  autoload :Oauth, "adcloud/oauth"
  autoload :Report, "adcloud/report"
  
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
  c.http_open_timeout = 5
  c.http_read_timeout = 10
  c.debug = true
  # c.app_key
  # c.app_secret
end