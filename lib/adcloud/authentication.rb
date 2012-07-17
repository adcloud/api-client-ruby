module Adcloud
  
  class Authentication
    
    attr_accessor :client_id, :client_secret, :token

    def initialize(attr)
      @client_id = attr[:client_id]
      @client_secret = attr[:client_secret]      
    end

    def connection
      conn = Faraday.new(:url => "#{Adcloud.config.protocol}://#{Adcloud.config.host}:#{Adcloud.config.port}") do |faraday|
        faraday.request  :url_encoded                     # form-encode POST params
        faraday.response :logger if Adcloud.config.debug  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter          # make requests with Net::HTTP
      end
    end

    # curl -X POST -d  "client_id=<ID>&client_secret=<SECRET>&grant_type=none"  "http://<URL>/v2/oauth/access_token"
    # The response will look like this:
    # {"access_token":"<ACCESS_TOKEN>","scope":""}
    def authenticate!
      path = "/v2/oauth/access_token"
      params = {:client_id => self.client_id, :client_secret => self.client_secret, :grant_type => "none"}
      #Adcloud.logger.debug('Adcloud::Authentication') { "Starting: #{self.inspect}" } if Adcloud.config.debug
      response = connection.post path, params
      if response.success?
        @token = JSON.parse(response.body)["access_token"]
        #Adcloud.logger.debug('Adcloud::Authentication') { "Token: #{@token}" } if Adcloud.config.debug
      else
        raise AuthenticationError.new(@client_id => "Could not authenticate")
      end 
      #Adcloud.logger.debug('Adcloud::Authentication') { "Ending: #{self.inspect}" } if Adcloud.config.debug
    end

  end
end
