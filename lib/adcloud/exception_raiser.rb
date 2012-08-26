module Adcloud

  class ExceptionRaiser

    def initialize(response)
      case response.status
      when 400
        raise Adcloud::BadRequestError.new(response)
      when 404
        raise Adcloud::NotFoundError.new(response)
      when 500
        raise Adcloud::ServerError.new(response)
      else
        raise StandardError.new("Could not handle status #{response.status}")
      end
    end

  end

end