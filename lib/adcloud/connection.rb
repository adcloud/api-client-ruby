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

    def url
      "#{Adcloud.config.protocol}://#{Adcloud.config.host}:#{Adcloud.config.port}/#{Adcloud.config.api_version}/"
    end

    def authentication_token
      self.authentication.token
    end

    def connection(auth = true)
      auth_header = auth && { :Authorization =>  "Bearer #{authentication_token}" } || {}
      connection ||= Faraday.new(:url => url, :headers => {}.merge(auth_header)) do |faraday|
        faraday.request  :url_encoded                     # form-encode POST params
        faraday.response :logger                          # log requests to STDOUT
        faraday.use ResponseErrorHandler
        faraday.adapter  Faraday.default_adapter          # make requests with Net::HTTP        
        faraday.response :json, :content_type => /\bjson$/
      end
    end

    def post(path, params = {})
      response = connection.post path, params
      response.body
    end

    def get(path, params = {})
      response = connection.get path, params
      response.body      
    end

  end
end
