require 'faraday'

module Adcloud

  class ResponseErrorHandler < Faraday::Response::Middleware

    def call(env)
      @app.call(env).on_complete do
        response = env[:response]
        # Todo comment in when ready
        # raise AdcloudUnknownAPIError::InvalidApiResponse unless response.body.has_key?("_meta")
        if response.success?
          response.body
        else
          ExceptionRaiser.new(response)
        end
      end
    end

  end

end