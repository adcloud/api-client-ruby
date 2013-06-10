module Adcloud

  class ApiError < StandardError;

    attr_accessor :meta, :response

    def initialize(response)
      self.response = response
    end

    def meta
      self.response.body["_meta"]
    end

    def details
      self.meta["details"]
    end

    def type
      self.meta["type"]
    end

    def message
      self.meta["message"]
    end

    def status
      self.meta["status"]
    end

    def to_s
      self.response.message
    end

  end

end