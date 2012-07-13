require 'net/http'
require 'net/https'
require 'digest'
require 'logger'
require 'json'
require 'base64'
require 'active_support/configurable'

module Adcloud
  autoload :Ad, "adcloud/ad"
  autoload :Attachment, "adcloud/attachment"
  autoload :Campaign, "adcloud/campaign"
  autoload :Oauth, "adcloud/oauth"
  autoload :Report, "adcloud/report"
  
  class Configuration
    include ActiveSupport::Configurable
  end

  class << self
    
    Adcloud::Configuration.configure do |c|
      c.port = 80
      c.protocol = 'https'
      c.host = 'api.adcloud.net'
      c.http_open_timeout = 5
      c.http_read_timeout = 10
      c.debug = true
      # c.app_key
      # c.app_secret
    end

    # Access the logger instance
    def logger
      @@logger ||= Adcloud::Configuration.config.logger || Logger.new(STDOUT)
    end

    # Allow to override the logger
    def logger=(input)
      @@logger = input
    end
   
  end

end