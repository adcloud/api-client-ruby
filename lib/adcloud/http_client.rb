module Adcloud
  
  class HTTPClient

    def connection
      # token = self.authentication.token
    end

    def authentication
      # @authentication ||= begin
      #   auth = Authentication.new(....)
      #   auth.authenticate!
      #   auth
      # end
    end

    def post(path, data)
      # token = Adcloud::Authentication.new.token
      # Farraday.post(url, token, data)
      # connection.post(.....)
    end

    def get(path, data)
      # token = Adcloud::Authentication.token      
      # Farraday.get(url, token, data)      
    end

  end
end
