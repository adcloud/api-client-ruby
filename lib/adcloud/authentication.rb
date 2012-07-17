module Adcloud
  
  class Authentication
    
    # curl -X POST -d  "client_id=<ID>&client_secret=<SECRET>&grant_type=none"  "http://<URL>/v2/oauth/access_token"
    # The response will look like this:
    # {"access_token":"<ACCESS_TOKEN>","scope":""}
    def token
      Adcloud.logger.debug('Adcloud::Authentication') { "Starting: #{self.inspect}" } if Adcloud.config.debug
      @token ||= begin
        url = "#{Adcloud.config.protocol}://#{Adcloud.config.host}:#{Adcloud.config.port}"
        path = "/v2/oauth/access_token"
        params = {:client_id => Adcloud.config.client_id, :client_secret => Adcloud.config.client_secret, :grant_type => "none"}
        conn = Faraday.new(:url => url) do |faraday|
          faraday.request  :url_encoded                     # form-encode POST params
          faraday.response :logger if Adcloud.config.debug  # log requests to STDOUT
          faraday.adapter  Faraday.default_adapter          # make requests with Net::HTTP
        end
        response = conn.post path, params
        if response.success?
          @token = JSON.parse(response.body)["access_token"]
          Adcloud.logger.debug('Adcloud::Authentication') { "Token: #{@token}" } if Adcloud.config.debug
        else
          raise AuthenticationError.new(Adcloud.config.client_id => "Could not authenticate")
        end 
      end
      Adcloud.logger.debug('Adcloud::Authentication') { "Ending: #{self.inspect}" } if Adcloud.config.debug      
    end

  end
end
