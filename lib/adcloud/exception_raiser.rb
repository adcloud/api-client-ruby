module Adcloud

  class ExceptionRaiser

    def initialize(response)
      Adcloud.logger.warn { "API Exception #{response.inspect}" }

      case response.status
      when 400
        raise Adcloud::BadRequestError.new(response)
      when 401
        raise Adcloud::Unauthorized.new(response)
      when 404
        raise Adcloud::NotFoundError.new(response)
      when 500
        raise Adcloud::ServerError.new(response)
      else
        raise Adcloud::UnknownError.new(response)
      end
    end

  end

end