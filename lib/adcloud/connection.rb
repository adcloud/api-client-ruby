module Adcloud
  
  class Connection < Adcloud::Entity

    attr_accessor :authentication

    def authentication
      @authentication ||= begin
        auth = Adcloud::Authentication.new(:client_id => Adcloud.config.client_id, :client_secret => Adcloud.config.client_secret)
        auth.authenticate!
        auth
      end
    end

    def connection
      Adcloud.logger.debug('Adcloud::Authentication') { "Opening Connection" } if Adcloud.config.debug
      connection ||= Faraday.new(:url => "#{Adcloud.config.protocol}://#{Adcloud.config.host}:#{Adcloud.config.port}/#{Adcloud.config.api_version}/") do |faraday|
        faraday.request  :url_encoded                     # form-encode POST params
        faraday.response :logger                          # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter          # make requests with Net::HTTP
      end
      Adcloud.logger.debug('Adcloud::Authentication') { "Connection: #{@connection}" } if Adcloud.config.debug      
      connection
    end

    # Move it to Faraday Middleware
    def post(path, data = {})
      params = data.merge(:access_token => self.authentication.token)
      connection.post path, params
    end

    def get(path, data = {})
      params = data.merge(:access_token => self.authentication.token)
      connection.get path, params
    end

  end
end
