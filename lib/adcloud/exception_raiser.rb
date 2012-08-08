module Adcloud

  class ExceptionRaiser

    def initialize(response)
      case response.status
      when 400
        raise BadRequestError.new(response)
      when 404
        raise NotFoundError.new(response)
      when 500
        raise ServerError.new(response)
      else
        raise StandardError.new("Could not handle status #{response.status}")
      end
    end

  end

end