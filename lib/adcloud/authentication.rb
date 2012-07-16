module Adcloud
  
  class Authentication
    
    # curl -X POST -d  "client_id=<ID>&client_secret=<SECRET>&grant_type=none"  "http://<URL>/v2/oauth/access_token"
    # The response will look like this:
    # {"access_token":"<ACCESS_TOKEN>","scope":""}
    def token
      # @token ||= begin
        # response = Farraday.post("#{Adcloud.configure.protocol}://#{Adcloud.configure.host}:#{Adcloud.configure.port}/access_token?client_id=#{Adcloud.configure.client_id}&client_secret=#{Adcloud.configure.client_secret})
        # if response.success?
        #   @token = JSON.parse(response.body)["access_token"]
        # else
        #  Exception.new .........
        # end 
      # end
    end

  end
end
