require 'net/http'
require 'net/https'
require 'digest'
require 'logger'
require 'json'
require 'base64'
require 'active_support/configurable'
require 'faraday'

module Adcloud

  class AuthenticationError   < StandardError ; end

  include ActiveSupport::Configurable

  autoload :Ad, "adcloud/ad"
  autoload :Attachment, "adcloud/attachment"
  autoload :Campaign, "adcloud/campaign"
  autoload :Authentication, "adcloud/authentication"
  autoload :Report, "adcloud/report"  
  autoload :Connection, "adcloud/connection"

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
  c.debug = false
  # c.authentication = Adcloud::Authentication.new(:client_id => "1234567890", :client_secret => "1234567890")
end