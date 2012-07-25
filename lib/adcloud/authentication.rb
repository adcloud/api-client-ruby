module Adcloud

  class AuthenticationError    < StandardError ; end
    
  class Authentication
    
    attr_accessor :client_id, :client_secret, :token

    def initialize(attr)
      @client_id = attr[:client_id]
      @client_secret = attr[:client_secret]      
    end

    def authenticate!
      response = Connection.new.connection(false).post "oauth/access_token", {:client_id => self.client_id, :client_secret => self.client_secret, :grant_type => "none"}
      if response.success?
        @token = JSON.parse(response.body)["access_token"]
      else
        raise AuthenticationError.new(@client_id => "Could not authenticate")
      end 
    end

  end
end
