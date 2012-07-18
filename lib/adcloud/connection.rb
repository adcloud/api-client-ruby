module Adcloud
  
  class Connection

    attr_accessor :authentication, :connection

    def connection
      Adcloud.logger.debug('Adcloud::Authentication') { "Opening Connection" } if Adcloud.config.debug
      @connection ||= Faraday.new(:url => "#{Adcloud.config.protocol}://#{Adcloud.config.host}:#{Adcloud.config.port}") do |faraday|
        faraday.request  :url_encoded                     # form-encode POST params
        faraday.response :logger                          # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter          # make requests with Net::HTTP
      end
      Adcloud.logger.debug('Adcloud::Authentication') { "Connection: #{@connection}" } if Adcloud.config.debug      
      @connection
    end

    def authentication
      @authentication ||= begin
        auth = Adcloud::Authentication.new(:client_id => Adcloud.config.client_id, :client_secret => Adcloud.config.client_secret)
        auth.authenticate!
        auth
      end
    end

    def post(path, data)
      # token = @authentication.token
      # Farraday.post(url, token, data)
      # connection.post(.....)
    end

    def get(path, data)
      # token = @authentication.token
      # Farraday.get(url, token, data)      
    end

  end
end
