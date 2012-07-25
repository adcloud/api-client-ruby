module Adcloud
  
  class InvalidFilter          < StandardError ; end
  class InvalidRequest         < StandardError ; end
  class NotFound               < StandardError ; end

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
      auth_header = {}
      auth_header = {:Authorization =>  "Bearer #{authentication_token}"} if auth
      Adcloud.logger.debug('Adcloud::Authentication') { "Opening Connection" } if Adcloud.config.debug
      connection ||= Faraday.new(:url => url, :headers => {}.merge(auth_header)) do |faraday|
      # connection ||= Faraday.new(:url => url) do |faraday|
        faraday.request  :url_encoded                     # form-encode POST params
        faraday.response :logger                          # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter          # make requests with Net::HTTP
      end
      Adcloud.logger.debug('Adcloud::Authentication') { "Connection: #{@connection}" } if Adcloud.config.debug      
      connection
    end

    # Move it to Faraday Middleware
    def post(path, params = {})
      response = connection.post path, params
      if response.success?
        JSON.parse(response.body)
      else
        # Campaign.create
        raise InvalidRequest.new(JSON.parse(response.body)["_meta"])
      end
    end

    def get(path, params = {})
      response = connection.get path, params
      if response.success?
        JSON.parse(response.body)
      elsif response.status == 400
        # Campaign.all
        raise InvalidFilter.new(JSON.parse(response.body)["_meta"])
      elsif response.status == 404
        # Campaign.find
        raise NotFound.new(JSON.parse(response.body)["_meta"])        
      else
        # Campaign.all
        # Campaign.find
        raise InvalidRequest.new(JSON.parse(response.body)["_meta"])
      end
    end

  end
end
